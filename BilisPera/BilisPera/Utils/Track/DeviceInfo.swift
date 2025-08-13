//
//  DeviceInfo.swift
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

import Foundation
import DeviceKit

class DeviceInfo: NSObject {
    
    @objc static func getDiagonal() -> String{
        return "\(Device.current.diagonal)"
    }
}
