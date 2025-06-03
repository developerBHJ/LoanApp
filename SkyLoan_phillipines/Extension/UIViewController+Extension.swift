//
//  UIViewController+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/14.
//

import UIKit

protocol TopMostViewControllerProviding{
    var topMostViewController: UIViewController? {get}
}

struct TopMostViewControllerProvider: TopMostViewControllerProviding {
    var topMostViewController: UIViewController?{
        UIViewController.topMost
    }
}

extension UIViewController{
    @objc func presentFullScreenAndDisablePullToDismiss(){
        modalPresentationStyle = .overCurrentContext
        if #available(iOS 13.0, *){
            isModalInPresentation = true
        }
    }
    
    func showCustomAlert(model: CustomAlertView.Model = .init()){
        let alertVC = CustomAlertView.init(model: model)
        present(alertVC, animated: false)
    }
    
    func hideCustomAlertView(completion: (()-> Void)? = nil){
        guard let topVC = UIViewController.topMost as? CustomAlertView else {
            return
        }
        topVC.dismiss(animated: false,completion: completion)
    }
    
   @objc func popNavigation(animated: Bool = true){
        if let _ = self.presentingViewController {
            dismiss(animated: animated)
        }else{
            navigationController?.popViewController(animated: animated)
        }
    }
    
    func showCustomAlert(title: String,message: String,confirmCompletion: (()-> Void)? = nil,cancelCompletion: (()-> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertWindow = alertController.view
        alertWindow?.backgroundColor = .white
        alertWindow?.tintColor = kColor_black
        if let label = alertController.view.subviews.first?.subviews.first as? UILabel {
            label.textColor = UIColor.black
            label.font = SLFont(size: 14)
        }
        let confirmAction = UIAlertAction(title: "confirm", style: .destructive) { action in
            confirmCompletion?()
        }
        confirmAction.setValue(UIColor.blue, forKeyPath: "_titleTextColor")
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel) { action in
            self.dismiss(animated: true)
            cancelCompletion?()
        }
        cancelAction.setValue(UIColor.gray, forKeyPath: "_titleTextColor")
        alertController.addAction(cancelAction)
        // 显示警告框
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController{
    
    @objc public class var topMost: UIViewController?{
        guard let currentWindows = getCurrentWindows() else {
            return nil
        }
        guard let rootViewController = getRootViewController(currentWindows: currentWindows) else {
            return nil
        }
        return topMost(of: rootViewController)
    }
    
    public class var sharedApplication: UIApplication?{
        let selector = NSSelectorFromString("sharedApplication")
        return UIApplication.perform(selector).takeUnretainedValue() as? UIApplication
    }
    
    class func getCurrentWindows() -> [UIWindow]?{
        sharedApplication?.windows
    }
    
    class func getRootViewController(currentWindows: [UIWindow]) -> UIViewController?{
        currentWindows.filter({$0.isKeyWindow}).first?.rootViewController
    }
    
    public class func topMost(of viewController: UIViewController) -> UIViewController{
        // presentedViewController
        if let presentedViewController = viewController.presentedViewController {
            return topMost(of: presentedViewController)
        }
        // tabBarController
        if let tabBarController = viewController as? UITabBarController,let selectedViewController = tabBarController.selectedViewController{
            return topMost(of: selectedViewController)
        }
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,let visibedViewController = navigationController.visibleViewController{
            return topMost(of: visibedViewController)
        }
        // UIPageViewController
        if let pageViewController = viewController as? UIPageViewController,let viewController = pageViewController.viewControllers?.first{
            return topMost(of: viewController)
        }
        // childViewController
        for subView in viewController.view.subviews{
            if let childViewController = subView.next as? UIViewController{
                return topMost(of: childViewController)
            }
        }
        return viewController
    }
    
    public class func topMostNavigationController(of viewController: UIViewController) -> UINavigationController?{
        // presentedViewController
        if let presentedViewController = viewController.presentedViewController {
            return topMostNavigationController(of: presentedViewController)
        }
        // tabBarController
        if let tabBarController = viewController as? UITabBarController,let selectedViewController = tabBarController.selectedViewController{
            return topMostNavigationController(of: selectedViewController)
        }
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,let visibedViewController = navigationController.visibleViewController{
            return topMostNavigationController(of: visibedViewController)
        }
        return viewController.navigationController
    }
    
    @objc public class var topMostTabBarController: UITabBarController?{
        guard let currentWindows = getCurrentWindows() else {
            return nil
        }
        return getTopMostTabBarController(currentWindows: currentWindows)
    }
    
    class func getTopMostTabBarController(currentWindows: [UIWindow]) -> UITabBarController?{
        guard let rootViewController = getRootViewController(currentWindows: currentWindows) else {
            return nil
        }
        return topMostTabBarController(of: rootViewController)
    }
    
    public class func topMostTabBarController(of controller: UIViewController) -> UITabBarController?{
        if let result = controller as? UITabBarController{
            return result
        }
        if let result = controller.tabBarController{
            return result
        }
        // presentedViewController
        if let presentedViewController = controller.presentedViewController{
            return topMostTabBarController(of: presentedViewController)
        }
        // childViewController
        for subView in controller.view.subviews{
            if let childViewController = subView.next as? UIViewController{
                return topMostTabBarController(of: childViewController)
            }
        }
        return nil
    }
}


extension UIScene.ActivationState{
    var sortPriority: Int{
        switch self {
        case .unattached:
            return 4
        case .foregroundActive:
            return 1
        case .foregroundInactive:
            return 2
        case .background:
            return 3
        @unknown default:
            return 5
        }
    }
}

public extension UIViewController{
    private static var animationTypeKey = "animationTypeKey";
    var animationType:UIViewControllerAnimationType{
        set {
            objc_setAssociatedObject(self,  &UIViewController.animationTypeKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        get {
            if objc_getAssociatedObject(self, &UIViewController.animationTypeKey) is UIViewControllerAnimationType {
                return (objc_getAssociatedObject(self, &UIViewController.animationTypeKey) as? UIViewControllerAnimationType)!;
            }
            return UIViewControllerAnimationType(rawValue: 0)!;
        }
    }
}
