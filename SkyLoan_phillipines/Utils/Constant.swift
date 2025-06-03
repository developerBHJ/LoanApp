//
//  Constant.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/12.
//

import Foundation
import UIKit

func HJPrint<T>(_ m:T, file: String = #file, function: String = #function, line: Int = #line) {
#if DEBUG
    let fileName = (file as NSString).lastPathComponent
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    let date = Date()
    let dateString = dateFormatter.string(from: date)
    print("")
    print("----LOGBEGAN--- \(fileName): \(line) \(function)--------")
    print("\(dateString) \(m)")
    print("----LOGEND-----")
#endif
}

let kScreenW = UIScreen.main.bounds.size.width
let kScreenH = UIScreen.main.bounds.size.height
let kStatusBarH = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 20
let kNavigationBarH = 50 + kStatusBarH

func getNotchHeight() -> CGFloat {
    guard let window = UIApplication.shared.windows.first else {
        return 0
    }
    let bottomSafeArea = window.safeAreaInsets.bottom
    return bottomSafeArea
}


let kRatio = CGFloat( kScreenH / 872)

let kCountryCode = "+63"

// MARK:-UIDevice
/// 设备名
let deviceName = UIDevice.current.name
/// 系统版本
let sysVersion = UIDevice.current.systemVersion
/// UUID
let deviceUUID = UIDevice.current.identifierForVendor?.uuidString
/// 设备型号
let deviceModel = UIDevice.current.model
/// 系统版本
let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"

let kH5Host = "http://8.220.149.161:9993"
let kH5Host1 = "https://8.220.149.161:9993"
let kApiHost = "http://8.220.149.161:9993/skyloanapi"
let kLocaleLanguage = JourneyLocale.en
/// 系统评分页面
let kAppStoreRatingPage = "https://itunes.apple.com/app/id123456789?action=write-review"

enum HtmlPath: String {
    /// 隐私协议
    case privacy = "/vanillaGarl"
    /// 确认用款页
    case confirmLoan = "/creamEggpla"
    /// 订单详情页
    case loanDetail = "/ggplantBerr"
    /// 联登失败页
    case loginFail = "/mangoRadish"
    /// 还款页
    case rePayment = "/rhinocerosA"
    /// 客服中心
    case customerService = "/irisMilletP"
    /// 智能客服中心
    case service = "/xiaoxueCogn"
    /// 联系我们
    case contactUs = "/lemonJackfr"
    /// 借款协议
    case loanAgreement = "/cucumberYew"
}

extension HtmlPath{
    var url: String{
        return kH5Host.appending(self.rawValue)
    }
}

extension Notification.Name{
    enum Login {
        static let login = Notification.Name("NotificationName_login")
        static let loginOut = Notification.Name("NotificationName_loginOut")
        static let logOff = Notification.Name("NotificationName_loginOff")
    }
}
