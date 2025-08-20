//
//  ProfileViewController+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/14.
//

import UIKit

extension ProfileViewController{
    enum Constant {
        static let backColor = kColor_333333?.withAlphaComponent(0.5)
    }
}

extension ProfileViewController{
    @objc func backEvent(){
        popNavigation()
    }
    
    func itemClick(type: ProfileListType){
        switch type {
        case .order:
            let orderVC = OrderViewController()
            self.navigationController?.pushViewController(orderVC, animated: true)
        case .service:
            RouteManager.shared.routeTo(HtmlPath.customerService.url)
        case .privacy:
            RouteManager.shared.routeTo(HtmlPath.privacy.url)
        case .exit:
            loginOut()
        case .logOff:
            loginOff()
        }
    }
    
    func loginOut(){
        let model = CustomAlertView.Model.init(type: .exit,closeCompletion: nil,confirmCompletion: {[weak self] in
            self?.hideCustomAlertView(){
                Task{
                    if await self?.viewModel.logOut() == true{
                        LoginTool.shared.clearUserData()
                        self?.popNavigation()
                        NotificationCenter.default.post(name:  Notification.Name.Login.loginOut, object: nil)
                    }
                }
            }
        }) {[weak self] in
            self?.hideCustomAlertView()
        }
        showCustomAlert(model: model)
    }
    
    func loginOff(){
        let model = CustomAlertView.Model.init(type: .cancellation,closeCompletion: nil,confirmCompletion: {[weak self] in
            if self?.viewModel.loginOffPrivary == true {
                self?.hideCustomAlertView(){
                    Task{
                        if await self?.viewModel.logOff() == true{
                            LoginTool.shared.clearUserData()
                            self?.popNavigation()
                            NotificationCenter.default.post(name:  Notification.Name.Login.logOff, object: nil)
                        }
                    }
                }
            }else{
                SLProgressHUD.showToast(message: LocalizationConstants.Profile.cancellation_tips)
            }
        }) {[weak self] in
            self?.hideCustomAlertView()
        }checkBoxCompletion: {[weak self] selected in
            self?.viewModel.loginOffPrivary = selected
        }
        showCustomAlert(model: model)
    }
}
