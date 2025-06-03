//
//  OrderListModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/21.
//

import Foundation
enum OrderStatus: Int,BaseEnum {
    case delay = 1
    case repayment = 2
    case apply = 3
    case review = 4
    case finish = 5
}

extension OrderStatus{
    var statusImage: String{
        switch self {
        case .delay:
            "icon_order_status_delay"
        case .repayment:
            "icon_order_status_repayment"
        case .apply:
            "icon_order_status_apply"
        case .review:
            "icon_order_status_review"
        case .finish:
            "icon_order_status_review_grey"
        }
    }
}

struct OrderListModel:BaseModel {
    // 订单ID
    var utter: Int = 0
    var persons: PersonsModel? = nil
}

struct PersonsModel: BaseModel {
    /// 订单ID
    var utter: Int = 0
    /// 产品ID
    var awful: Int = 0
    /// logo
    var pause: String = ""
    /// 产品名称
    var fun: String = ""
    /// 订单状态
    var terrible: Int = 0
    /// 右上角订单状态文案
    var morning: String = ""
    /// 金额描述
    var witnesses: String = ""
    /// 金额
    var necessity: String = ""
    /// 日期文案
    var murderess: String = ""
    /// 日期
    var murderer: String = ""
    /// 期限文案
    var outside: String = ""
    /// 期限
    var space: String = ""
    /// 按钮文案  返回空时说明不用展示按钮
    var inclosed: String = ""
    /// 订单描述文案
    var mid: String = ""
    /// 类型 1逾期 2还款中 3未申请 4审核中 5已完成  此字段用户判断背景色等
    var accident: OrderStatus = .finish
    /// 点击跳转--h5跳转地址或原生跳转地址
    var suicide: String = ""
}
