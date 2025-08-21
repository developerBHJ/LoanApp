//
//  BPLocationManager.swift
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

import Foundation
import CoreLocation
import Combine

@objc
class BPLocationManager: NSObject, @preconcurrency CLLocationManagerDelegate {
    let geocoder = CLGeocoder()
    
    @MainActor @objc static let shared = BPLocationManager()
    
    @MainActor
   @objc func startLocationRequest(completion: (() -> Void)? = nil) {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.startUpdatingLocation()
        Task{
            try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
            completion?();
        }
    }
    
    @MainActor
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        manager.stopUpdatingLocation()
        let model = BPLocationModel.init()
        model.sighted = "\(location.coordinate.latitude)"
        model.hills = "\(location.coordinate.longitude)"
        UserDefaults.standard.set(model, forKey: userLocationKey)
        reverseGeocodeLocation(coordinate: location.coordinate)
    }
    
    @MainActor func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        manager.stopUpdatingLocation()
    }
    
    @MainActor
    func reverseGeocodeLocation(coordinate: CLLocationCoordinate2D){
        geocoder
            .reverseGeocodeLocation(CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)){[weak self] (
                placemarks,
                error
            ) in
                guard let self,let placemarks = placemarks, let place = placemarks.first else {
                    return
                }
                var model = BPLocationModel()
                if let m = UserDefaults.standard.object(forKey: userLocationKey) as? BPLocationModel{
                    model = m;
                }
                model.astonishing = place.isoCountryCode ?? ""
                model.stopped = place.country ?? ""
                model.truly = place.administrativeArea ?? (place.locality ?? "")
                model.theplain = place.locality ?? ""
                model.horizon = place.name ?? ""
                UserDefaults.standard.set(model, forKey: userLocationKey)
            }
    }
    
    @objc func getUserLocation() -> BPLocationModel?{
        return UserDefaults.standard
            .object(forKey: userLocationKey) as? BPLocationModel
    }
}
