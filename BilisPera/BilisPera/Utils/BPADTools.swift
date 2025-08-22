//
//  BPADTools.swift
//  BilisPera
//
//  Created by BHJ on 2025/8/22.
//

import Foundation
import AdSupport
import AppTrackingTransparency
import UIKit

@objc
@MainActor
class BPADTools: NSObject {
   @objc static let shared = BPADTools()
   private let idfvString: String = UIDevice.current.identifierForVendor?.uuidString ?? ""
    @objc var trackCount: Int = 0
    
   @objc func registerIDFAAndTrack(){
        Task{
            let delay = UInt64(1.5) * 1_000_000_000
            try await Task.sleep(nanoseconds: delay)
            defer{
                if self.trackCount < 2{
                    TrackTools.shared().trackForGoogleMarket()
                    self.trackCount += 1
                }
            }
            guard await registerIDFA() else {return}
        }
    }
    
  @objc  func registerIDFA() async -> Bool{
        let status =  await ATTrackingManager.requestTrackingAuthorization()
        switch status {
        case .authorized:
            // 用户已授权，可以访问IDFA
            let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            if let idfaData = idfa.data(using: .utf8) {
                _ = BPKeyChainWrapper.save(key: "IDFA", data: idfaData)
            }
            if let idfvData = self.idfvString.data(using: .utf8){
                _ = BPKeyChainWrapper.save(key: "IDFV", data: idfvData)
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
    
  @objc func getIDFV() -> String{
        guard let data = BPKeyChainWrapper.load(key: "IDFV"),let string = String(data: data, encoding: .utf8) else { return ""}
        return string
    }
    
   @objc func getIDFA() -> String{
      return  ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
}
