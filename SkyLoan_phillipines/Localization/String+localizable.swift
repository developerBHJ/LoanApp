//
//  String+localizable.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/13.
//

import Foundation
public enum JourneyLocale: String{
    case en
}

extension String{
    func localized(using tabName: String? = LocalizationConstants.localizableFileName,
                   in bundle: Bundle = Bundle.main,
                   with local: JourneyLocale = .en)-> String{
        if let path = bundle.path(forResource: local.rawValue, ofType: "lproj"),let localizedBundle = Bundle(path: path){
            return localizedBundle.localizedString(forKey: self, value: nil, table: tabName)
        }
        return self
    }
}

extension LocalizationConstants{
    enum Login {
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var app_name = "login_appName"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var phoneViewTitle = "login_phone_title"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var phoneViewPlaceHolder = "login_phone_placeHolder"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var codeViewTitle = "login_code_title"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var codeViewPlaceHolder = "login_code_placeHolder"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var sendTitle = "login_sendButton_title"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var privacyPre = "login_privacy_notice"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var privacyTap = "login_privacy_tap"
    }
    
    enum Alert {
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var stay_content = "alert_stay_content"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var stay_confirm = "alert_stay_button_confirm"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var stay_cancel = "alert_stay_button_cancel"
        
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var exit_content = "alert_exit_content"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var exit_confirm = "alert_exit_button_confirm"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var exit_cancel = "alert_exit_button_cancel"
        
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var cancellation_content = "alert_cancellation_content"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var cancellation_confirm = "alert_cancellation_button_confirm"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var cancellation_cancel = "alert_cancellation_button_cancel"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var cancellation_privacy = "alert_cancellation_privacy"
        @Localized(tableName: LocalizationConstants.localizableFileName)
        static var selectedCityToast = "selecte_city_toast"
    }
    
    enum HomePage {
        @Localized(tableName: LocalizationConstants.homeFileName)
        static var kingKong_left = "home_kingKong_left"
        @Localized(tableName: LocalizationConstants.homeFileName)
        static var kingKong_middle = "home_kingKong_middle"
        @Localized(tableName: LocalizationConstants.homeFileName)
        static var kingKong_right = "home_kingKong_right"
    }
    
    enum Profile {
        @Localized(tableName: LocalizationConstants.profile)
        static var list_order = "list_order"
        @Localized(tableName: LocalizationConstants.profile)
        static var list_service = "list_service"
        @Localized(tableName: LocalizationConstants.profile)
        static var list_privacy = "list_privacy"
        @Localized(tableName: LocalizationConstants.profile)
        static var list_exit = "list_exit"
        @Localized(tableName: LocalizationConstants.profile)
        static var list_logOff = "list_logOff"
        @Localized(tableName: LocalizationConstants.profile)
        static var profile_version = "profile_version"
    }
    
    enum Order {
        @Localized(tableName: LocalizationConstants.order)
        static var nav_title = "order_nav_title"
        @Localized(tableName: LocalizationConstants.order)
        static var empty_title = "order_empty_title"
        @Localized(tableName: LocalizationConstants.order)
        static var empty_content = "order_empty_content"
        @Localized(tableName: LocalizationConstants.order)
        static var empty_button = "order_empty_button"
        @Localized(tableName: LocalizationConstants.order)
        static var net_title = "order_nonet_title"
        @Localized(tableName: LocalizationConstants.order)
        static var net_content = "order_nonet_content"
        @Localized(tableName: LocalizationConstants.order)
        static var net_button = "order_nonet_button"
    }
    
    enum Product{
        @Localized(tableName: LocalizationConstants.product)
        static var nav_title = "product_nav_title"
        @Localized(tableName: LocalizationConstants.product)
        static var header_title = "product_head_title"
        @Localized(tableName: LocalizationConstants.product)
        static var header_idCard = "product_head_iDCard"
        @Localized(tableName: LocalizationConstants.product)
        static var header_face = "product_head_face"
        @Localized(tableName: LocalizationConstants.product)
        static var item_finish = "product_item_status_finish"
        @Localized(tableName: LocalizationConstants.product)
        static var item_unFinish = "product_item_status_unFinish"
        @Localized(tableName: LocalizationConstants.product)
        static var bottomButtonTitle = "product_bottomButton_title"
        @Localized(tableName: LocalizationConstants.product)
        static var idCardBottomButtonTitle = "product_idCard_bottom_buttonTitle"
        @Localized(tableName: LocalizationConstants.product)
        static var idCardBottomButtonTitle1 = "product_idCard_bottom_buttonTitle1"
        @Localized(tableName: LocalizationConstants.product)
        static var idCardRequireTitle = "product_idCard_requireTitle"
        @Localized(tableName: LocalizationConstants.product)
        static var idCardRequire = "product_idCard_require"
        static var faceRequireTitle = "product_face_requireTitle"
        @Localized(tableName: LocalizationConstants.product)
        static var faceRequire = "product_face_require"
        @Localized(tableName: LocalizationConstants.product)
        static var idCardTips = "product_idCard_tips"
        @Localized(tableName: LocalizationConstants.product)
        static var faceTips = "product_face_tips"
        @Localized(tableName: LocalizationConstants.product)
        static var idCardSlogn = "product_idCard_slogn"
        @Localized(tableName: LocalizationConstants.product)
        static var faceSlogn = "product_face_slogn"
        @Localized(tableName: LocalizationConstants.product)
        static var alertBottomButton = "product_alert_bottom_buttonTitle"
        @Localized(tableName: LocalizationConstants.product)
        static var authenInfoName = "product_authen_info_name"
        @Localized(tableName: LocalizationConstants.product)
        static var authenInfoNumber = "product_authen_info_number"
        @Localized(tableName: LocalizationConstants.product)
        static var authenInfoBirthday = "product_authen_info_birthday"
        @Localized(tableName: LocalizationConstants.product)
        static var authenResultName = "product_authen_result_name"
        @Localized(tableName: LocalizationConstants.product)
        static var authenResultNumber = "product_authen_result_number"
        @Localized(tableName: LocalizationConstants.product)
        static var authenResultBirthday = "product_authen_result_birthday"
        @Localized(tableName: LocalizationConstants.product)
        static var nextStep = "product_next_step"
        @Localized(tableName: LocalizationConstants.product)
        static var fullAddressPlaceHolder = "product_company_address_placeholder"
    }
}
