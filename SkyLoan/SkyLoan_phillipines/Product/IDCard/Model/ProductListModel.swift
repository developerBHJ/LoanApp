//
//  ProductListModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/22.
//

import Foundation

enum ProductItemType: String,BaseEnum {
    /// public
    case iDCard = "nicebluef"
    /// personal
    case basic = "niceblueg"
    /// work
    case work = "niceblueh"
    /// ext
    case contact = "nicebluei"
    /// bank
    case bank = "nicebluej"
}

extension ProductItemType{
    var imageName: String{
        switch self {
        case .iDCard:
            return "icon_product_IDInfo"
        case .basic:
            return "icon_product_basic"
        case .work:
            return "icon_product_work"
        case .contact:
            return "icon_product_contacts"
        case .bank:
            return "icon_product_receipt"
        }
    }
}

enum ProductFormType: String,BaseEnum {
    /// enum
    case picker = "nicebluek"
    /// txt
    case text = "nicebluel"
    /// citySelect
    case citySelect = "nicebluem"
}

struct ProductListModel:BaseModel {
    /// 标题
    var feel: String = ""
    /// 副标题
    var tea: String = ""
    ///
    var general: Int = -1
    /// url
    var somehow: String = ""
    /// 是否已完成认证 0否1是
    var late: Int = 0
    /// url
    var mind: String = ""
    ///
    var fast: ProductItemType = .iDCard
    ///
    var cheeks: Int = 0
    ///
    var flush: Int = 0
    ///
    var won: Int = 0
    ///
    var muddled: String = ""
    /// 认证logo
    var hot: String = ""
}
