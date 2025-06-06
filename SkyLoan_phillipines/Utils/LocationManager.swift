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

class LocationManager {
    static let shared = LocationManager()
    var model = LocationModel()
    
    @MainActor
    func startLoaction() async -> Bool{
        return await withCheckedContinuation { continuation in
            SLProgressHUD.showWindowesLoading()
            let locationMananger = CLLocationManager()
            let locationPublisher = locationMananger.publisher(for: \.location).compactMap{$0}
            let _ = locationPublisher.sink {[weak self] location in
                self?.model.cleared = "\(location.coordinate.latitude)"
                self?.model.cobra = "\(location.coordinate.longitude)"
//                HJPrint("latitude=\(location.coordinate.latitude) longitude=\(location.coordinate.longitude)")
                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(location){[weak self] (placemarks, error) in
                    if let placemarks = placemarks, let place = placemarks.first{
                        self?.model.astonishing = place.isoCountryCode ?? ""
                        self?.model.doubt = place.country ?? ""
                        self?.model.incredible = place.administrativeArea ?? ""
                        self?.model.deadlier = place.locality ?? ""
                        self?.model.jury = place.name ?? ""
                        continuation.resume(returning: true)
                    }else{
                        continuation.resume(returning: false)
                    }
                    SLProgressHUD.hideHUDQueryHUD()
                }
            }
        }
    }
}
