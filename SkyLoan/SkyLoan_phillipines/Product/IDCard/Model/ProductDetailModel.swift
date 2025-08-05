//
//  ProductDetailModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/23.
//

import Foundation

struct ProductDetailModel:BaseModel {
    var disdainful: Int = 0
    var somehow: String = ""
    /// 产品信息
    var confusion: Confusion? = nil
    /// 认证项
    var comrades: [ProductListModel]? = nil
    /// 下一步
    var brain: BrainModel? = nil
}

struct Confusion:BaseModel {
    /// 产品id
    var confidential: String = ""
    /// 产品名称
    var fun: String = ""
    /// 订单号
    var ass: String = ""
    /// 订单ID
    var utter: Int = 0
    /// 金额
    var blushing: String = ""
    /// 金额描述
    var stammering: String = ""
    /// 期限
    var cup: String = ""
    /// 期限描述
    var stopped: String = ""
    /// 利率
    var impulsively: String = ""
    /// 利率描述
    var misfortune: String = ""
}

struct BrainModel:BaseModel {
    /// 判断此字段，如果为空的话 说明认证项已经全部认证成功，如果有值，就跳转到对应认证项里
    var fast: ProductItemType? = nil
    var somehow: String = ""
    var general: Int = 0
    /// 下一步的标题
    var feel: String = ""
}
