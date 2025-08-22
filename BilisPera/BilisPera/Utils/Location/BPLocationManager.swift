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
    var manager = CLLocationManager()
    
    @MainActor @objc static let shared = BPLocationManager()
    
    @MainActor
   @objc func startLocationRequest(completion: (() -> Void)? = nil) {
        manager = CLLocationManager()
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
        saveUserLocation(model: model)
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
                if let m = getUserLocation(){
                    model = m;
                }
                model.astonishing = place.isoCountryCode ?? ""
                model.stopped = place.country ?? ""
                model.truly = place.administrativeArea ?? (place.locality ?? "")
                model.theplain = place.locality ?? ""
                model.horizon = place.name ?? ""
                saveUserLocation(model: model)
            }
    }
    
    @objc func getUserLocation() -> BPLocationModel?{
        var model: BPLocationModel?
       if let dic = UserDefaults.standard
        .object(forKey: userLocationKey){
           do {
               let jsonData = try JSONSerialization.data(withJSONObject: dic as Any)
               let decoder = JSONDecoder()
               model = try decoder.decode(BPLocationModel.self, from: jsonData)
           } catch {
               print("转换失败: \(error)")
           }
       }
        return model
    }
    
    private func saveUserLocation(model: BPLocationModel){
        let dic = model.toDictionary()
        UserDefaults.standard.set(dic, forKey: userLocationKey)
    }
}
