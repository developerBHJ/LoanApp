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
                showCustomAlert(title: "", message: "To use Sky Loan,you must enable location permissions to use the Appfunctions normally", confirmCompletion:  {
                    RouteManager.shared.routeTo("blue://sky.yes.app/lasagnaGiraf")
                })
                return false
            }
        }else{
            return true
        }
    }
    
    @objc func showDrawerView(){
        self.animationType = .rlScanAnimation
        let profileVC = ProfileViewController()
        profileVC.completion = {
            _ = LoginTool.shared.checkLogin()
        }
        let navVC = BaseNavigationController(rootViewController: profileVC)
        navVC.presentFullScreenAndDisablePullToDismiss()
        self.present(navVC, animated: true)
    }
    
    @objc func onPushOrderView() {
        Task{
            let result = await chekPermissions()
            guard result else {return}
            _ = await LocationManager.shared.startLoaction()
            if TrackMananger.shared.startTime > 0{
                TrackMananger.shared.trackRisk(type: .register, productId: "")
            }
            TrackMananger.shared.trackLoacationInfo(paramas: LocationManager.shared.model.toDictionary() ?? [:])
            TrackMananger.shared.trackDeviceInfo()
            self.animationType = .noneAnimation
            self.navigationController?.pushViewController(OrderViewController(), animated: true)
        }
    }
    
    func onPushWebView(url: String) {
        Task{
            let result = await chekPermissions()
            guard result else {return}
            _ = await LocationManager.shared.startLoaction()
            if TrackMananger.shared.startTime > 0{
                TrackMananger.shared.trackRisk(type: .register, productId: "")
            }
            RouteManager.shared.routeTo(url)
        }
    }
    
    func onPushDetailView(productId: String) {
        Task{
            let result = await chekPermissions()
            guard result else {return}
            _ = await LocationManager.shared.startLoaction()
            if TrackMananger.shared.startTime > 0{
                TrackMananger.shared.trackRisk(type: .register, productId: "")
            }
            TrackMananger.shared.trackLoacationInfo(paramas: LocationManager.shared.model.toDictionary() ?? [:])
            TrackMananger.shared.trackDeviceInfo()
            ProductEntrance.shared.onPushAuthenView(productId: productId)
        }
    }
    
    func kingKongEvent(type: HomeKingKongCell.ButtonType) {
        switch type {
        case .condition:
            RouteManager.shared.routeTo(HtmlPath.loanAgreement.url)
        case .detail:
            Task{
                let result = await chekPermissions()
                guard result else {return}
                _ = await LocationManager.shared.startLoaction()
                if TrackMananger.shared.startTime > 0{
                    TrackMananger.shared.trackRisk(type: .register, productId: "")
                }
                TrackMananger.shared.trackLoacationInfo(paramas: LocationManager.shared.model.toDictionary() ?? [:])
                TrackMananger.shared.trackDeviceInfo()
                self.animationType = .noneAnimation
                guard let productId = viewModel.infoModel.romance?.winning?.first?.confidential else {return}
                ProductEntrance.shared.apply(productId: "\(productId)")
            }
        case .contact:
            RouteManager.shared.routeTo(HtmlPath.contactUs.url)
        }
    }
}
