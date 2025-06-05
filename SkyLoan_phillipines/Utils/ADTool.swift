//
//  ADTool.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/20.
//

import Foundation
import AdSupport
import AppTrackingTransparency
import UIKit

class ADTool {
    static let shared = ADTool()
    let idfvString: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
    var idfaString: String = ""
    var trackCount: Int = 0
    
    func registerIDFAAndTrack(){
        Task{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                [weak self] in
                guard let self else {return}
                self.registerIDFA()
                guard self.trackCount < 3 else {return}
                TrackMananger.shared.trackGoogleMarket()
                self.trackCount += 1
            })
        }
    }
    
    func registerIDFA() {
        ATTrackingManager.requestTrackingAuthorization(){
            status in
            switch status {
            case .authorized:
                // 用户已授权，可以访问IDFA
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                ADTool.shared.idfaString = idfa
                if let idfvData = self.idfvString.data(using: .utf8){
                    _ = KeychainWrapper.save(key: "IDFV", data: idfvData)
                }
            case .denied, .notDetermined, .restricted:
                HJPrint("Tracking authorization denied")
            @unknown default:
                break
            }
        }
    }
}
