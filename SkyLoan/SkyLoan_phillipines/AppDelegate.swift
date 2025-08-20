//
//  AppDelegate.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/12.
//

import UIKit
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var launchStartTime: Date?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        launchStartTime = Date()
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = BaseNavigationController.init(rootViewController: HomePageViewController())
        IQKeyboardManager.shared().isEnabled = true
        if let window = UIApplication.shared.windows.first {
            if let rootVC = window.rootViewController as? UINavigationController {
                rootVC.interactivePopGestureRecognizer?.isEnabled = false
            }
        }
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if let start = launchStartTime {
            let duration = Int(Date().timeIntervalSince(start))
            TrackMananger.shared.launchTime = duration
        }
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let _ = url.scheme{
            RouteManager.shared.routeTo(url.absoluteString)
            return true
        } else {
           return ApplicationDelegate.shared.application(
                app,
                open: url,
                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
            )
        }
    }
}

