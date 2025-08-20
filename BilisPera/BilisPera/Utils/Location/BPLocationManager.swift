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
class LocationManager: NSObject {
    private var activeRequests: [UUID: SingleLocationRequest] = [:]
    private let lockQueue = DispatchQueue(label: "com.location.service.lock")
    
    @MainActor func requestSingleLocation(timeOut: Bool = true,completion: @escaping (BPLocationModel?, Error?) -> Void) -> UUID? {
        let requestId = UUID()
        let manager = CLLocationManager()
        let request = SingleLocationRequest(
            manager: manager,
            timeOut: timeOut,
            completion: completion,
            requestId: requestId
        )
        
        manager.delegate = request
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        lockQueue.sync {
            activeRequests[requestId] = request
        }
        request.startLocationRequest()
        return requestId
    }
    
    func cancelRequest(id: UUID) {
        cleanRequest(id: id)
    }
    
    func cleanRequest(id: UUID) {
        lockQueue.sync {
            guard let request = activeRequests[id] else { return }
            request.manager.stopUpdatingLocation()
            request.manager.delegate = nil
            activeRequests[id] = nil
        }
    }
}

private class SingleLocationRequest: NSObject, @preconcurrency CLLocationManagerDelegate {
    let manager: CLLocationManager
    let completion: (BPLocationModel?, Error?) -> Void
    let requestId: UUID
    let duration: TimeInterval = 6
    let timeOut: Bool
    let geocoder = CLGeocoder()
    var locationModel = BPLocationModel.init()
    var timeoutWorkItem: DispatchWorkItem?
    
    init(manager: CLLocationManager,timeOut: Bool,
         completion: @escaping (BPLocationModel?, Error?) -> Void,
         requestId: UUID) {
        self.manager = manager
        self.completion = completion
        self.requestId = requestId
        self.timeOut = timeOut
        super.init()
    }
    
    @MainActor
    func startLocationRequest() {
        manager.delegate = self
        manager.startUpdatingLocation()
        self.timeoutWorkItem = DispatchWorkItem {
            [weak self] in
            guard let self else {return}
            self.setDefaultLocation()
            self.completion(self.locationModel,nil)
            LocationManager.shared.cleanRequest(id: requestId)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: self.timeoutWorkItem!)
        if self.timeOut {
            
        }
    }
    
    @MainActor
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        manager.stopUpdatingLocation()
        locationModel.sighted = "\(location.coordinate.latitude)"
        locationModel.hills = "\(location.coordinate.longitude)"
        TrackTools.shared().defaultCoordinate = location.coordinate
        reverseGeocodeLocation(coordinate: location.coordinate)
    }
    
    @MainActor func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        setDefaultLocation()
        completion(locationModel, error)
        manager.stopUpdatingLocation()
        LocationManager.shared.cleanRequest(id: requestId)
    }
    
    @MainActor
    func reverseGeocodeLocation(coordinate: CLLocationCoordinate2D){
        geocoder.reverseGeocodeLocation(CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)){[weak self] (placemarks, error) in
            guard let self,let placemarks = placemarks, let place = placemarks.first else {return}
            self.locationModel.astonishing = place.isoCountryCode ?? ""
            self.locationModel.stopped = place.country ?? ""
            self.locationModel.truly = place.administrativeArea ?? (place.locality ?? "")
            self.locationModel.theplain = place.locality ?? ""
            self.locationModel.horizon = place.name ?? ""
            completion(locationModel,nil)
            LocationManager.shared.cleanRequest(id: requestId)
        }
    }
    
    private func setDefaultLocation(){
        locationModel.sighted = "\(TrackTools.shared().defaultCoordinate.latitude)"
        locationModel.hills = "\(TrackTools.shared().defaultCoordinate.longitude)"
    }
}

extension LocationManager {
    @MainActor static let shared = LocationManager()
}

