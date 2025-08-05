//
//  AddressModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/27.
//

import Foundation

struct AddressModel:BaseModel {
    var article: String = ""
    var trust: [AddressModel] = []
    /// 第1级的展示名称
    var nowadays: String = ""
    var confidential: Int = 0
}
