//
//  ProfileListModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/14.
//

import Foundation

enum ProfileListType: String {
    case order
    case service
    case privacy
    case exit
    case logOff
}

extension ProfileListType{
    var linkUrl: String{
        switch self {
        case .order:
            return ""
        case .service:
            return ""
        case .privacy:
            return ""
        case .exit:
            return ""
        case .logOff:
            return ""
        }
    }
}

struct ProfileListModel {
    let title: String
    let icon: String
    var type: ProfileListType = .order
    var rightArrow: String = "icon_profile_arrow"
    var originX: CGFloat = 0
}
