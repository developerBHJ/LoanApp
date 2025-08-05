//
//  ReceiptListModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/29.
//

import Foundation

enum ReceiptBankType:Int, BaseEnum {
    case e_wallet = 1
    case bank = 2
}

struct ReceiptListModel:BaseModel {
    var feel: String = ""
    var general: ReceiptBankType = .bank
    var stared: [PersonalBasicModel] = []
}

struct ReceiptInputItem:BaseModel {
    var feel: String = ""
    var article: String = ""
    var tea: String = ""
    var bow: String = ""
    var definitely: [ProductFormItem] = []
    var flush: Int = 0
    var late: Int = 0
    var mind: String = ""
    /// 下拉的value值    最终展示字段
    var laughed: String = ""
    /// 下拉的key值       最终传参字段
    var general: String = ""
    var whose: String = ""
    var laugh: Int = 0
    var clear: Int = 0
}
