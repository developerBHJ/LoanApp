//
//  TrackMananger.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/20.
//

import Foundation
import FBSDKCoreKit
import Network
import DeviceKit

enum TrackRiskType: Int {
    case register = 1
    case authenSelect = 2
    case idInfo = 3
    case face = 4
    case personal = 5
    case workInfo = 6
    case contacts = 7
    case receipt = 8
    case apply = 9
    case finish = 10
}

class TrackMananger {
    static let shared = TrackMananger()
    /// 纬度
    var longitude: CGFloat = 0
    /// 经度
    var latitude: CGFloat = 0
    var startTime: TimeInterval = 0
    var endTime: TimeInterval = 0
    var launchTime: TimeInterval = 0
    
    var deviceModel: TrackDeviceModel = .init()
    
    func trackGoogleMarket(){
        Task{
            let paramas = ["paralyzing": ADTool.shared.idfvString,"acts":ADTool.shared.idfaString]
            let result: [String: Any]? = await HttpRequestDictionary(TrackAPI.trackGoogleMarket(dic: paramas))
            resetTimer()
            if let paramas = result?["tclbook"] as? [String: String]{
                registerFaceBook(dic: paramas)
            }
        }
    }
    
    private func registerFaceBook(dic: [String: String]){
        Settings.shared.appID = dic["catmimi"] ?? ""
        Settings.shared.clientToken = dic["bigdan"]
        Settings.shared.displayName = dic["yuouou"]
        Settings.shared.appURLSchemeSuffix = dic["chinbook"]
        ApplicationDelegate.shared.application(UIApplication.shared)
    }
    
    private func resetTimer(){
        endTime = 0
        startTime = 0
    }
    
    func trackLoacationInfo(paramas: [String: Any]){
        Task{
            let _: [String: Any]? = await HttpRequestDictionary(TrackAPI.trackLocationInfo(dic: paramas))
        }
    }
    
    func trackDeviceInfo(){
        Task{
            guard let json = creatDeviceInfo() else {return}
            let _: [String: Any]? = await HttpRequestDictionary(TrackAPI.trackDeviceInfo(dic: ["howl":json]))
        }
    }
    
    func trackRisk(type: TrackRiskType,productId: String){
        Task{
            var paramas: [String: Any] = [:]
            paramas["awful"] = productId
            paramas["causes"] = type.rawValue
            paramas["ass"] = ""
            paramas["gun"] = ADTool.shared.idfvString
            paramas["shot"] = ADTool.shared.idfaString
            paramas["cobra"] = LocationManager.shared.model.cobra
            paramas["cleared"] = LocationManager.shared.model.cleared
            paramas["jackal"] = startTime
            paramas["giftdrawn"] = endTime
            paramas["needle"] = randomUUIDString()
            let _: [String: Any]? = await HttpRequestDictionary(TrackAPI.trackRiskInfo(dic: paramas))
            resetTimer()
        }
    }
    
    func tackContactsInfo(paramas: [String: String]){
        Task{
            let _: [String: Any]? = await HttpRequestDictionary(TrackAPI.trackContacts(dic: paramas))
            resetTimer()
        }
    }
    
    private func creatDeviceInfo() -> String?{
        var model = TrackDeviceModel.init()
        model.died = "iOS"
        model.hyena = sysVersion
        model.realized = Bundle().bundleIdentifier ?? ""
        model.virulence = getBatteryLevel()
        model.effect = TrackDeviceModel.getEffectModel()
        model.trace = TrackDeviceModel.getTraceModel()
        model.analyst = TrackDeviceModel.getAnalystModel()
        model.dreamy = TrackDeviceModel.getDreamyModel()
        do{
            let jsonData = try JSONSerialization.data(
                withJSONObject: model.toDictionary() ?? [:],
                options: [.sortedKeys]
            )
            let base64String = jsonData.base64EncodedString()
            return base64String
        }catch{
            return nil
        }
    }
    
    func getBatteryLevel() -> Virulence {
        var model = Virulence.init()
        UIDevice.current.isBatteryMonitoringEnabled = true
        model.intense = Int(UIDevice.current.batteryLevel * 100)
        model.human = UIDevice.current.batteryState == .charging ? 1: 0
        return model
    }
}

extension TrackDeviceModel{
    
    static func getEffectModel() -> Effect{
        var effectModel = Effect.init()
        effectModel.paralyzing = ADTool.shared.idfvString
        effectModel.acts = ADTool.shared.idfaString
        let wifiModel = TrackDeviceModel.getAnalystModel()
        effectModel.existence = wifiModel.expression?.existence ?? ""
        effectModel.deadly = WifiUtils.isProxyEnabled() ? 1 : 0
        effectModel.snake = WifiUtils.isVPNConnected() ? 1 : 0
        effectModel.tree = WifiUtils.checkSymbolicLink() ? 1:0
        effectModel.boomslang = WifiUtils.isSimulator ? 1 : 0
        effectModel.typus = JourneyLocale.en.rawValue
        effectModel.dispholidus = WifiUtils.getCarrierName() ?? ""
        effectModel.venom = WifiUtils.getCellularNetworkGeneration().rawValue
        if let abbreviation = TimeZone.current.abbreviation() {
            effectModel.recently = abbreviation
        }
        effectModel.according = Int(TrackMananger.shared.launchTime)
        return effectModel
    }
    
    static func getTraceModel() -> TraceModel{
        var model = TraceModel.init()
        model.gusto = deviceModel
        model.used = Int(kScreenH)
        model.preparation = Int(kScreenW)
        model.dipped = Device.current.name ?? ""
        model.sent = UIDevice.current.model
        model.fatal = Device.current.localizedModel ?? ""
        model.poisons = "\(Device.current.diagonal)"
        model.rare = UIDevice.current.systemVersion
        return model
    }
    
    static func getAnalystModel() -> AnalystModel{
        var model = AnalystModel.init()
        model.government = WifiUtils.getLocalIPAddress() ?? ""
        model.learn = []
        if let currentWifi = WifiUtils.getCurrentWifiInfo(){
            model.expression = .init(nowadays: "",shock: currentWifi.bssid,existence: currentWifi.bssid,stupid: currentWifi.ssid)
            model.benignant = 1
        }else{
            model.benignant = model.learn.count
        }
        return model
    }
    
    static func getDreamyModel() -> DreamyModel{
        var model = DreamyModel.init()
        let totalMemory = ProcessInfo.processInfo.physicalMemory
        model.winterspoon = Int(TrackDeviceModel.getFreeDiskSpace() ?? 0)
        model.wrote = Int(TrackDeviceModel.getTotalDiskSpace() ?? 0)
        model.attentively = Int(totalMemory)
        model.instantaneous = Int(TrackDeviceModel.systemFreeMemory())
        return model
    }
    
    static func getTotalDiskSpace() -> Int64? {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
              let space = systemAttributes[.systemSize] as? Int64 else {
            return 0
        }
        return space
    }
    
    static func getFreeDiskSpace() -> Int64? {
        guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()),
              let freeSpace = systemAttributes[.systemFreeSize] as? Int64 else {
            return 0
        }
        return freeSpace
    }
    
    static func systemFreeMemory() -> UInt64 {
         var stats = vm_statistics64()
         var count = UInt32(MemoryLayout.size(ofValue: stats)/MemoryLayout.size(ofValue: stats.free_count))
         let result = withUnsafeMutablePointer(to: &stats) {
             $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                 host_statistics64(mach_host_self(), HOST_VM_INFO64, $0, &count)
             }
         }
         guard result == KERN_SUCCESS else { return 0 }
         return UInt64(stats.free_count) * UInt64(vm_page_size)
     }
}

