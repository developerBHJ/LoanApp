//
//  LoginTool.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/14.
//

import Foundation
import UIKit

class LoginTool {
    static let shared = LoginTool()
    let tokenKey = "token"
    let userNameKey = "userName"
    var addressList: [AddressModel] = []
    
    func checkLogin(needLogin: Bool = true,completion: (() -> Void)? = nil) -> Bool{
        if !getToken().isEmpty{
            return true
        }else{
            if needLogin{
                showLoginView(completion: completion)
            }
            return false
        }
    }
    
    func showLoginView(completion: (() -> Void)? = nil){
        guard let topVC = UIViewController.topMost, (topVC is LoginViewController) == false else {return}
        let loginVC = LoginViewController()
        loginVC.presentFullScreenAndDisablePullToDismiss()
        topVC.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func getToken() -> String{
        let token = UserDefaults.standard.string(forKey: tokenKey)
        return token ?? ""
    }
    
    func getUserName() -> String{
        let userName = UserDefaults.standard.string(forKey: userNameKey)
        return userName ?? ""
    }
    
    func clearUserData(){
        UserDefaults.standard.set(nil, forKey: tokenKey)
        UserDefaults.standard.set(nil, forKey: userNameKey)
    }
    
    func requestAddressList() async{
        let result: [String: Any]? = await HttpRequestDictionary(ProductAPI.getAddressList)
        if let list = result?["trust"] as? [[String: Any]]{
            let addressList = AddressModel.modelArray(from: list)
            self.addressList = addressList
        }
    }
}
