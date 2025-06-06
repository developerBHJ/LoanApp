//
//  LoginViewModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/20.
//

import Foundation
import Combine

class LoginViewModel {
    var phone: String = ""{
        didSet{
            loginButtonEnabled()
        }
    }
    var code: String = ""{
        didSet{
            loginButtonEnabled()
        }
    }
    var isSelected: Bool = true{
        didSet{
            loginButtonEnabled()
        }
    }
    
    var loginEnabled: PassthroughSubject<Bool,Never> = PassthroughSubject<Bool,Never>.init()
    
    func loginButtonEnabled(){
        let isEnabled = isSelected && !code.isEmpty && !phone.isEmpty
        loginEnabled.send(isEnabled)
    }
    
    func getVerifyCode() async -> Bool{
        guard !phone.isEmpty else {return false}
        let result: [String:Any]? = await HttpRequestDictionary(LoginAPI.getVerifyCode(pay: phone), showMessage: true)
        return result != nil
    }
    
    @MainActor
    func login() async -> Bool{
        guard isSelected,!code.isEmpty,!phone.isEmpty else {return false}
        var paramas: [String: Any] = [:]
        paramas["weekly"] = phone
        paramas["represent"] = code
        paramas["assurance"] = 1
        paramas["glib"] = 1
        paramas["hat"] = kLocaleLanguage.rawValue
        paramas["lifted"] = randomUUIDString()
        if let result: [String:Any] = await HttpRequestDictionary(LoginAPI.login(dic: paramas), showMessage: true){
            if let token = result["crowded"] as? String,!token.isEmpty{
                UserDefaults.standard.set(token, forKey: LoginTool.shared.tokenKey)
                NotificationCenter.default.post(name:  Notification.Name.Login.login, object: nil)
                let userName = result["weekly"] as? String ?? ""
                UserDefaults.standard.set(userName, forKey: LoginTool.shared.userNameKey)
                return true
            }
            return false
        }
        return false
    }
}
