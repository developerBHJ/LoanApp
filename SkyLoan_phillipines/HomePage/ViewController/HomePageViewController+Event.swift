//
//  HomePageViewController+Event.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/21.
//

import Foundation
import CoreLocation

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
            await updateLocation()
            self.animationType = .noneAnimation
            self.navigationController?.pushViewController(OrderViewController(), animated: true)
        }
    }
    
    func onPushWebView(url: String) {
        Task{
            let result = await chekPermissions()
            guard result else {return}
            await updateLocation()
            RouteManager.shared.routeTo(url)
        }
    }
    
    func onPushDetailView(productId: String) {
        Task{
            let result = await chekPermissions()
            guard result else {return}
            await updateLocation()
            ProductEntrance.shared.apply(productId: productId)
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
                await updateLocation()
                self.animationType = .noneAnimation
                guard let productId = viewModel.infoModel.romance?.winning?.first?.confidential else {return}
                ProductEntrance.shared.apply(productId: "\(productId)")
            }
        case .contact:
            RouteManager.shared.routeTo(HtmlPath.customerService.url)
        }
    }
    
    @MainActor
    func updateLocation() async{
        let location = await startLoaction()
        self.viewModel.location.cleared = location.0
        self.viewModel.location.cobra = location.1
        if viewModel.location.cleared.isEmpty {
            viewModel.location.cleared = LocationManager.shared.model.cleared
        }
        if viewModel.location.cobra.isEmpty {
            viewModel.location.cobra = LocationManager.shared.model.cobra
        }
        if TrackMananger.shared.startTime > 0{
            TrackMananger.shared.trackRisk(type: .register, productId: "")
        }
        TrackMananger.shared.trackLoacationInfo(paramas: viewModel.location.toDictionary() ?? [:])
        TrackMananger.shared.trackDeviceInfo()
//        HJPrint("latitude=\(viewModel.location.cleared) longitude=\(viewModel.location.cobra)")
    }
    
    @MainActor
    func startLoaction() async -> (String,String){
        return await withCheckedContinuation { continuation in
            SLProgressHUD.showWindowesLoading()
            let locationMananger = CLLocationManager()
            let locationPublisher = locationMananger.publisher(for: \.location).compactMap{$0}
            let _ = locationPublisher.sink {[weak self] location in
                continuation.resume(returning: ("\(location.coordinate.latitude)","\(location.coordinate.longitude)"))
                LocationManager.shared.model.cleared = "\(location.coordinate.latitude)"
                LocationManager.shared.model.cobra = "\(location.coordinate.longitude)"
                //                self?.model.cleared = "\(location.coordinate.latitude)"
                //                self?.model.cobra = "\(location.coordinate.longitude)"
                //                HJPrint("latitude=\(location.coordinate.latitude) longitude=\(location.coordinate.longitude)")
                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(location){[weak self] (placemarks, error) in
                    if let placemarks = placemarks, let place = placemarks.first{
                        self?.viewModel.location.astonishing = place.isoCountryCode ?? ""
                        self?.viewModel.location.doubt = place.country ?? ""
                        self?.viewModel.location.incredible = place.administrativeArea ?? ""
                        self?.viewModel.location.deadlier = place.locality ?? ""
                        self?.viewModel.location.jury = place.name ?? ""
                    }
                    SLProgressHUD.hideHUDQueryHUD()
                }
            }
        }
    }
}
