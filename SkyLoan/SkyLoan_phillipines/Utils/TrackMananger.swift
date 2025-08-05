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
import MachO
import CoreLocation

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
    var launchTime: Int = 0
    
    var deviceModel: TrackDeviceModel = .init()
    var trackTimeData: [Int: [String: Int]] = [:]
    var manager = LocationManager()
    var defaultCoordinate = CLLocationCoordinate2D.init()
    
    var rigsterStartTime: Int {
        trackTimeData[TrackRiskType.register.rawValue]?["startTime"] ?? 0
    }

    func trackGoogleMarket(){
        Task{
            let paramas = ["paralyzing": ADTool.shared.idfvString,"acts":ADTool.shared.idfaString]
            let result: [String: Any]? = await HttpRequestDictionary(TrackAPI.trackGoogleMarket(dic: paramas))
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
    
    func startTime(type: TrackRiskType){
        if var time = trackTimeData[type.rawValue] {
            time["startTime"] = Int(Date().timeIntervalSince1970)
            trackTimeData[type.rawValue] = time
        }else{
            var time: [String: Int] = [:]
            time["startTime"] = Int(Date().timeIntervalSince1970)
            trackTimeData[type.rawValue] = time
        }
    }
    
    func endTime(type: TrackRiskType){
        if var time = trackTimeData[type.rawValue] {
            time["endTime"] = Int(Date().timeIntervalSince1970)
            trackTimeData[type.rawValue] = time
        }else{
            var time: [String: Int] = [:]
            time["endTime"] = Int(Date().timeIntervalSince1970)
            trackTimeData[type.rawValue] = time
        }
    }
    
    private func resetTimer(){
        trackTimeData.removeValue(forKey: TrackRiskType.register.rawValue)
    }
    
    func trackLoacationInfo(){
        manager = LocationManager()
        manager.requestLocation() { model in
            Task{
                HJPrint("location 90=\(model)")
                let _: [String: Any]? = await HttpRequestDictionary(TrackAPI.trackLocationInfo(dic: model.toDictionary() ?? [:]))
            }
        }
    }
    
    func trackDeviceInfo(){
        Task{
            guard let json = creatDeviceInfo() else {return}
            let _: [String: Any]? = await HttpRequestDictionary(TrackAPI.trackDeviceInfo(dic: ["howl":json]))
        }
    }
    
    func trackRisk(type: TrackRiskType,productId: String){
        manager = LocationManager()
        manager.requestLocation() {[weak self] model in
            HJPrint("location 106=\(model)")
            var paramas: [String: Any] = [:]
            paramas["awful"] = productId
            paramas["causes"] = type.rawValue
            paramas["ass"] = ""
            paramas["gun"] = ADTool.shared.idfvString
            paramas["shot"] = ADTool.shared.idfaString
            paramas["cobra"] = model.cobra
            paramas["cleared"] = model.cleared
            var startTime: Int = 0
            var endTime: Int = 0
            if let dic = self?.trackTimeData[type.rawValue]{
                startTime = Int(dic["startTime"] ?? 0)
                endTime = Int(dic["endTime"] ?? 0)
            }
            paramas["jackal"] = startTime
            paramas["giftdrawn"] = endTime
            paramas["needle"] = randomUUIDString()
            self?.configDataAndTrackRisk(type: type, paramas: paramas)
        }
    }
    
    private func configDataAndTrackRisk(type: TrackRiskType,paramas: [String: Any]){
        Task{
            let _: [String: Any]? = await HttpRequestDictionary(TrackAPI.trackRiskInfo(dic: paramas))
            if type == .register{
                resetTimer()
            }
        }
    }
    
    func tackContactsInfo(paramas: [String: String]){
        Task{
            let _: [String: Any]? = await HttpRequestDictionary(TrackAPI.trackContacts(dic: paramas))
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
        effectModel.poisonous = Int(Date().timeIntervalSince1970)
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
            model.expression = .init(nowadays: currentWifi.ssid,shock: currentWifi.bssid,existence: currentWifi.bssid,stupid: currentWifi.ssid)
            model.benignant = 1
        }else{
            model.benignant = model.learn.count
        }
        return model
    }
    
    static func getDreamyModel() -> DreamyModel{
        var model = DreamyModel.init()
        model.winterspoon = Int(TrackDeviceModel.getFreeDiskSpace() ?? 0)
        model.wrote = Int(TrackDeviceModel.getTotalDiskSpace() ?? 0)
        model.attentively = Int(TrackDeviceModel.getTotalMemory())
        model.instantaneous = Int(TrackDeviceModel.getAvailableMemory())
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
    
    static func getAvailableMemory() -> UInt64 {
        var vmStats = vm_statistics64()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64>.size) / 4
        let result = withUnsafeMutablePointer(to: &vmStats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                host_statistics64(mach_host_self(), HOST_VM_INFO64, $0, &count)
            }
        }
        if result == KERN_SUCCESS {
            let pageSize = vm_kernel_page_size
            let freeMem = UInt64(vmStats.free_count) * UInt64(pageSize) + UInt64(vmStats.inactive_count) * UInt64(pageSize)
            return freeMem
        }
        return 0
    }
    
    static func getTotalMemory() -> UInt64{
        var vmStats = vm_statistics64()
        var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64>.size / MemoryLayout<integer_t>.size)
        let result = withUnsafeMutablePointer(to: &vmStats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics64(mach_host_self(), HOST_VM_INFO64, $0, &count)
            }
        }
        if result == KERN_SUCCESS {
            let totalPages = vmStats.free_count + vmStats.active_count +
            vmStats.inactive_count + vmStats.wire_count
            let totalMemory = UInt64(totalPages) * UInt64(vm_kernel_page_size)
            return totalMemory
        }
        return 0
    }
}

