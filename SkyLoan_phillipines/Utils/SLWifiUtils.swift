//
//  SLWifiUtils.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/6/3.
//

import SystemConfiguration.CaptiveNetwork
import CoreLocation
import NetworkExtension
import CoreTelephony

enum NetworkGeneration: String{
    case other = "OTHER"
    case g2 = "2G"
    case g3 = "3G"
    case g4 = "4G"
    case g5 = "5G"
    case wifi = "WIFI"
}

class WifiUtils {
    static let isSimulator: Bool = {
        var isSim = false
#if arch(i386) || arch(x86_64)
        isSim = true
#endif
        return isSim
    }()
    
    static func getCurrentWifiInfo() -> (ssid: String, bssid: String)? {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            return nil
        }
        for interface in interfaces {
            guard let info = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any] else {
                continue
            }
            if let ssid = info["SSID"] as? String,
               let bssid = info["BSSID"] as? String {
                return (ssid, bssid)
            }
        }
        return nil
    }
    
    static func isProxyEnabled() -> Bool {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() as? [String: Any] else {
            return false
        }
        guard let proxies = CFNetworkCopyProxiesForURL(URL(string: "https://www.baidu.com")! as CFURL, proxySettings as CFDictionary).takeUnretainedValue() as? [Any] else {
            return false
        }
        guard let proxy = proxies.first as? [String: Any],
              let proxyType = proxy[kCFProxyTypeKey as String] as? String else {
            return false
        }
        return proxyType != kCFProxyTypeNone as String
    }
    
    
    static func isVPNConnected() -> Bool {
        let manager = NEVPNManager.shared()
        var isConnected = false
        manager.loadFromPreferences { error in
            guard error == nil else { return }
            isConnected = (manager.connection.status == .connected)
        }
        return isConnected
    }
    
    static func checkSymbolicLink() -> Bool {
        var s = stat()
        return lstat("/Applications", &s) == 0 && (s.st_mode & S_IFLNK) == S_IFLNK
    }
    
    static func getCarrierName() -> String? {
        let networkInfo = CTTelephonyNetworkInfo()
        guard let carrier = networkInfo.serviceSubscriberCellularProviders?.first?.value
        else { return nil }
        return carrier.carrierName
    }
    
    static func getCellularNetworkGeneration() -> NetworkGeneration {
        let networkInfo = CTTelephonyNetworkInfo()
        guard let currentRadioTech = networkInfo.serviceCurrentRadioAccessTechnology?.first?.value
        else { return .other }
        if #available(iOS 14.1, *) {
            switch currentRadioTech {
            case CTRadioAccessTechnologyGPRS, CTRadioAccessTechnologyEdge:
                return .g2
            case CTRadioAccessTechnologyWCDMA, CTRadioAccessTechnologyHSDPA:
                return .g3
            case CTRadioAccessTechnologyLTE:
                return .g4
            case CTRadioAccessTechnologyNRNSA, CTRadioAccessTechnologyNR:
                return .g5
            default:
                return .other
            }
        } else {
            return .other
        }
    }
    
    static func getLocalIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ptr.pointee
            let addrFamily = interface.ifa_addr.pointee.sa_family
            // 筛选IPv4且非回环地址
            if addrFamily == UInt8(AF_INET) {
                let flags = Int32(interface.ifa_flags)
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr,
                                socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname,
                                socklen_t(hostname.count),
                                nil,
                                socklen_t(0),
                                NI_NUMERICHOST)
                    address = String(cString: hostname)
                    if address?.hasPrefix("127.") == false {
                        break
                    }
                }
            }
        }
        freeifaddrs(ifaddr)
        return address
    }
}

