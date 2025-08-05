//
//  LoginViewController+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/12.
//

import Foundation
extension LoginViewController{
    enum Constant {
        static let contentTop = kStatusBarH + CGFloat(168.ratio())
        static let contentTopCorner = CGFloat(26.ratio())
        static let title = LocalizationConstants.Login.app_name
        static let phoneViewTitle = LocalizationConstants.Login.phoneViewTitle
        static let phoneViewPlaceHolder = LocalizationConstants.Login.phoneViewPlaceHolder
        static let codeViewTitle = LocalizationConstants.Login.codeViewTitle
        static let codeViewPlaceHolder = LocalizationConstants.Login.codeViewPlaceHolder
        static let sendButtonTitle = LocalizationConstants.Login.sendTitle
        static let privacyPre = LocalizationConstants.Login.privacyPre
        static let privacyTap = LocalizationConstants.Login.privacyTap
        static let privacyLinkUrl = "https://www.baidu.com"
        static let loginButtonHeight =  CGFloat(56.ratio())
        static let loginButtonLeftSpace = CGFloat(44.ratio())
    }
}

