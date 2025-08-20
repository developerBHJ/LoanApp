//
//  HomePageViewController+Event.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/21.
//

import Foundation

protocol HomePageEventDelegate {
    func onPushWebView(url: String)
    func onPushDetailView(productId: String)
    func kingKongEvent(type: HomeKingKongCell.ButtonType)
}

extension HomePageViewController: HomePageEventDelegate{
    
    func chekPermissions() async -> Bool{
        let result = await PermissionHandle.shared.requestLocationAccess()
        if viewModel.needLocation{
            if result{
                return true
            }else{
                showCustomAlert(title: "", message: LocalizationConstants.Alert.alertMessage_location, confirmCompletion:  {
                    RouteManager.shared.routeTo("blue://sky.yes.app/lasagnaGiraf")
                })
                return false
            }
        }else{
            return true
        }
    }
    
    @objc func showDrawerView(){
        Task{
            let result = await chekPermissions()
            guard result else {return}
            self.animationType = .rlScanAnimation
            let profileVC = ProfileViewController()
            profileVC.completion = {
                _ = LoginTool.shared.checkLogin()
            }
            let navVC = BaseNavigationController(rootViewController: profileVC)
            navVC.presentFullScreenAndDisablePullToDismiss()
            self.present(navVC, animated: true)
        }
    }
    
    @objc func onPushOrderView() {
        Task{
            let result = await chekPermissions()
            guard result else {return}
//            updateLocation()
            animationType = .noneAnimation
            navigationController?.pushViewController(OrderViewController(), animated: true)
        }
    }
    
    func onPushWebView(url: String) {
        Task{
            let result = await chekPermissions()
            guard result else {return}
            self.updateLocation()
            RouteManager.shared.routeTo(url)
        }
    }
    
    func onPushDetailView(productId: String) {
        Task{
            let result = await chekPermissions()
            guard result else {return}
            self.updateLocation()
            ProductEntrance.shared.apply(productId: productId)
        }
    }
    
    func kingKongEvent(type: HomeKingKongCell.ButtonType) {
        switch type {
        case .condition:
            RouteManager.shared.routeTo(HtmlPath.privacy.url)
        case .detail:
            Task{
                let result = await chekPermissions()
                guard result else {return}
                updateLocation()
                self.animationType = .noneAnimation
                guard let productId = self.viewModel.infoModel.romance?.winning?.first?.confidential else {return}
                ProductEntrance.shared.apply(productId: "\(productId)")
            }
        case .contact:
            RouteManager.shared.routeTo(HtmlPath.customerService.url)
        }
    }
    
    @MainActor
    func updateLocation(){
        TrackMananger.shared.trackLoacationInfo()
        TrackMananger.shared.trackDeviceInfo()
        guard TrackMananger.shared.rigsterStartTime > 0 else {return}
        TrackMananger.shared.trackRisk(type: .register, productId: "")
    }
}

