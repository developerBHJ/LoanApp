//
//  PermissionHandle.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/24.
//

import Foundation
import AVFoundation
import Photos
import CoreLocation
import Combine
import Contacts

class PermissionHandle {
    static let shared = PermissionHandle()
    var cancellables = Set<AnyCancellable>()
    /// 纬度
    var longitude: CGFloat = 0
    /// 经度
    var latitude: CGFloat = 0
    
    func requestPhotoLibraryAccess() async -> Bool{
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            return await withCheckedContinuation { continuation in
                PHPhotoLibrary.requestAuthorization { status in
                    if status == .authorized{
                        continuation.resume(returning: true)
                    }else{
                        continuation.resume(returning: false)
                    }
                }
            }
        case .authorized:
            return true
        default:
            return false
        }
    }
    
    func requestCameraAccess() async -> Bool{
        return await withCheckedContinuation { continuation in
            AVCaptureDevice.requestAccess(for: .video){ status in
                continuation.resume(returning: status)
            }
        }
    }
    
    @MainActor
    func requestLocationAccess() async -> Bool{
        return await withCheckedContinuation { continuation in
            let locationMananger = CLLocationManager()
            if locationMananger.authorizationStatus == .authorizedWhenInUse || locationMananger.authorizationStatus == .authorizedAlways{
                continuation.resume(returning: true)
            }else{
                locationMananger.requestWhenInUseAuthorization()
                let publisher = locationMananger.publisher(for: \.authorizationStatus)
                let _ = publisher.sink { status in
                    if status == .authorizedWhenInUse || status == .authorizedAlways {
                        continuation.resume(returning: true)
                    }else{
                        continuation.resume(returning: false)
                    }
                }.store(in: &cancellables)
            }
        }
    }
    
    func requestContactsAccess() async -> Bool{
        return await withCheckedContinuation { continuation in
            let store = CNContactStore()
            let status = CNContactStore.authorizationStatus(for: .contacts)
            if status == .authorized{
                continuation.resume(returning: true)
            }else{
                store.requestAccess(for: .contacts){granted, error in
                    let status = CNContactStore.authorizationStatus(for: .contacts)
                    continuation.resume(returning: status == .authorized)
                }
            }
        }
    }
}

