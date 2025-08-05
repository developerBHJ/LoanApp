//
//  ProfileViewModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/22.
//

import Foundation

@MainActor
class ProfileViewModel {
    var dataSource: [ProfileListModel] = []
    var loginOffPrivary: Bool = false
    
    func configData(){
        dataSource = [
            ProfileListModel.init(title: LocalizationConstants.Profile.list_order, icon: "icon_profile_order",type: .order,originX: 52.ratio()),
            ProfileListModel.init(title: LocalizationConstants.Profile.list_service, icon: "icon_profile_service",type: .service,originX: 20.ratio()),
            ProfileListModel.init(title: LocalizationConstants.Profile.list_privacy, icon: "icon_profile_privacy",type: .privacy),
            ProfileListModel.init(title: LocalizationConstants.Profile.list_exit, icon: "icon_profile_exit",type: .exit,originX: 12.ratio()),
            ProfileListModel.init(title: LocalizationConstants.Profile.list_logOff, icon: "",type: .logOff,rightArrow: "icon_profile_arrow_grey",originX: 2.ratio())
        ]
    }
    
    func logOut() async -> Bool{
        let result: [String: Any]? = await HttpRequestDictionary(LoginAPI.loginOut)
        return result != nil
    }
    
    func logOff() async -> Bool{
        let result: [String: Any]? = await HttpRequestDictionary(LoginAPI.loginOff)
        return result != nil
    }
}
