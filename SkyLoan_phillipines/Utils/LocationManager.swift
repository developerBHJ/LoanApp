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
    private let operationQueue = DispatchQueue(label: "com.location.tracker.queue")
    private var timeoutWorkItem: DispatchWorkItem?
    private var manager: CLLocationManager?
    private var completionHandlers = [((LocationModel) -> Void)]()
    private let duration: TimeInterval = 30
    private let geocoder = CLGeocoder()
    private var locationModel = LocationModel.init()
    
    override init() {
        manager = CLLocationManager()
        super.init()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    func requestLocation(completion: @escaping (LocationModel) -> Void) {
        operationQueue.async { [weak self] in
            guard let self = self else { return }
            self.completionHandlers.append(completion)
            
            self.timeoutWorkItem = DispatchWorkItem {
                self.setDefaultLocation()
                self.executeCompletions(with: self.locationModel)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: self.timeoutWorkItem!)
            DispatchQueue.main.async {
                self.manager?.requestLocation()
            }
        }
    }
    
    private func executeCompletions(with model: LocationModel) {
        operationQueue.async { [weak self] in
            guard let self = self else { return }
            self.timeoutWorkItem?.cancel()
            self.completionHandlers.forEach { $0(model) }
            self.completionHandlers.removeAll()
        }
    }
    
    private func setDefaultLocation(){
        locationModel.cleared = "\(TrackMananger.shared.defaultCoordinate.latitude)"
        locationModel.cobra = "\(TrackMananger.shared.defaultCoordinate.longitude)"
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationModel.cleared = "\(location.coordinate.latitude)"
        locationModel.cobra = "\(location.coordinate.longitude)"
        TrackMananger.shared.defaultCoordinate = location.coordinate
        reverseGeocodeLocation(coordinate: location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        setDefaultLocation()
        executeCompletions(with: locationModel)
    }
    
    func reverseGeocodeLocation(coordinate: CLLocationCoordinate2D){
        geocoder.reverseGeocodeLocation(CLLocation.init(latitude: coordinate.latitude, longitude: coordinate.longitude)){[weak self] (placemarks, error) in
            guard let self,let placemarks = placemarks, let place = placemarks.first else {return}
            self.locationModel.astonishing = place.isoCountryCode ?? ""
            self.locationModel.doubt = place.country ?? ""
            self.locationModel.incredible = place.administrativeArea ?? (place.locality ?? "")
            self.locationModel.deadlier = place.locality ?? ""
            self.locationModel.jury = place.name ?? ""
            self.executeCompletions(with: locationModel)
        }
    }
}
