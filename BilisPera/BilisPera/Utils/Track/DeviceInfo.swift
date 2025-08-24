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
    
    @objc static func getIdentifier() -> String{
        var systemInfo = utsname()
        uname(&systemInfo)
        let mirror = Mirror(reflecting: systemInfo.machine)

        let identifier = mirror.children.reduce("") { identifier, element in
          guard let value = element.value as? Int8, value != 0 else { return identifier }
          return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    @objc static func getSysInfoByName(_ typeSpecifier: String) -> String? {
        var size: size_t = 0
        sysctlbyname(typeSpecifier, nil, &size, nil, 0)
        var answer = [CChar](repeating: 0, count: size)
        guard sysctlbyname(typeSpecifier, &answer, &size, nil, 0) == 0 else {
            return nil
        }
        let uInt8Array = answer.map { UInt8(bitPattern: $0) }
        let str = String(decoding: uInt8Array, as: UTF8.self)
        return str
    }
}
