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
   private let idfvString: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
    var trackCount: Int = 0
    
    func registerIDFAAndTrack(){
        Task{
            let delay = UInt64(1.5) * 1_000_000_000
            try await Task.sleep(nanoseconds: delay)
            defer{
                if self.trackCount < 2{
                    TrackMananger.shared.trackGoogleMarket()
                    self.trackCount += 1
                }
            }
            guard await registerIDFA() else {return}
        }
    }
    
    func registerIDFA() async -> Bool{
        let status =  await ATTrackingManager.requestTrackingAuthorization()
        switch status {
        case .authorized:
            // 用户已授权，可以访问IDFA
            let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            if let idfaData = idfa.data(using: .utf8) {
                _ = KeychainWrapper.save(key: "IDFA", data: idfaData)
            }
            if let idfvData = self.idfvString.data(using: .utf8){
                _ = KeychainWrapper.save(key: "IDFV", data: idfvData)
            }
            return true
        case .notDetermined:
            return await registerIDFA()
        case .denied, .restricted:
            return false
        @unknown default:
            return false
        }
    }
    
    func getIDFV() -> String{
        guard let data = KeychainWrapper.load(key: "IDFV"),let string = String(data: data, encoding: .utf8) else { return ""}
        return string
    }
    
    func getIDFA() -> String{
        ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
}
