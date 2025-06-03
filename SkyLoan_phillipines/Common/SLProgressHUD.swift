//
//  SLProgressHUD.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/19.
//

import Foundation
import MBProgressHUD

class SLProgressHUD {
    @MainActor
    static func showWindowesLoading(view: UIView? = nil,message: String = "",autoHide: Bool = false,animated: Bool = true){
        var superView = view
        if superView == nil{
            superView = UIApplication.shared.windows.first
        }
        guard let superView else {return}
        let hud = MBProgressHUD.showAdded(to: superView, animated: animated)
        hud.label.text = message
        hud.label.font = SLFont(size: 12, weight: .regular)
        hud.margin = 10.0
        guard autoHide else {return}
        hud.hide(animated: true, afterDelay: 3)
    }
    
    @MainActor
    static func showToast(view: UIView? = nil,message: String = ""){
        var superView = view
        if superView == nil{
            superView = UIApplication.shared.windows.first
        }
        guard let superView else {return}
        let hud = MBProgressHUD.showAdded(to: superView, animated: true)
        hud.mode = .text
        hud.label.text = message
        hud.label.font = SLFont(size: 12, weight: .regular)
        hud.margin = 10.0
        hud.hide(animated: true, afterDelay: 3)
    }
    
    @MainActor
    static func hideHUDQueryHUD(view: UIView? = nil){
        var superView = view
        if superView == nil{
            superView = UIApplication.shared.windows.first
        }
        guard let superView else {return}
        MBProgressHUD.hide(for: superView, animated: true)
    }
}
