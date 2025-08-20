//
//  LocationManager.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/31.
//

import Foundation
import CoreLocation
import Combine

struct LocationModel: BaseModel {
    /// 省
    var incredible: String = ""
    /// 国家code
    var astonishing: String = ""
    /// 国家
    var doubt: String = ""
    /// 街道
    var jury: String = ""
    /// 纬度
    var cleared: String = ""
    /// 经度
    var cobra: String = ""
    /// 市
    var deadlier: String = ""
}

class LocationManager: NSObject {
    private var activeRequests: [UUID: SingleLocationRequest] = [:]
    private let lockQueue = DispatchQueue(label: "com.location.service.lock")
    
    func requestSingleLocation(timeOut: Bool = true,completion: @escaping (LocationModel?, Error?) -> Void) -> UUID? {
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
        Task{
            await MainActor.run {
                request.startLocationRequest()
            }
        }
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

private class SingleLocationRequest: NSObject, CLLocationManagerDelegate {
    let manager: CLLocationManager
    let completion: (LocationModel?, Error?) -> Void
    let requestId: UUID
    let duration: TimeInterval = 6
    let timeOut: Bool
    let geocoder = CLGeocoder()
    var locationModel = LocationModel.init()
    var timeoutWorkItem: DispatchWorkItem?
    
    init(manager: CLLocationManager,timeOut: Bool,
         completion: @escaping (LocationModel?, Error?) -> Void,
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        manager.stopUpdatingLocation()
        locationModel.cleared = "\(location.coordinate.latitude)"
        locationModel.cobra = "\(location.coordinate.longitude)"
        TrackMananger.shared.defaultCoordinate = location.coordinate
        reverseGeocodeLocation(coordinate: location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        setDefaultLocation()
        completion(locationModel, error)
        manager.stopUpdatingLocation()
        LocationManager.shared.cleanRequest(id: requestId)
    }
    
    func reverseGeocodeLocation(coordinate: CLLocationCoordinate2D){
        geocoder.reverseGeocodeLocation(CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)){[weak self] (placemarks, error) in
            guard let self,let placemarks = placemarks, let place = placemarks.first else {return}
            self.locationModel.astonishing = place.isoCountryCode ?? ""
            self.locationModel.doubt = place.country ?? ""
            self.locationModel.incredible = place.administrativeArea ?? (place.locality ?? "")
            self.locationModel.deadlier = place.locality ?? ""
            self.locationModel.jury = place.name ?? ""
            completion(locationModel,nil)
            LocationManager.shared.cleanRequest(id: requestId)
        }
    }
    
    private func setDefaultLocation(){
        locationModel.cleared = "\(TrackMananger.shared.defaultCoordinate.latitude)"
        locationModel.cobra = "\(TrackMananger.shared.defaultCoordinate.longitude)"
    }
}

extension LocationManager {
    static let shared = LocationManager()
}

