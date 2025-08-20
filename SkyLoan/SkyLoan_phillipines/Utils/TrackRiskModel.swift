//
//  TrackRiskModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/6/9.
//

import Foundation

struct TrackRiskModel: BaseModel {
    /// productId
    var awful: String = ""
    /// risk类型
    var causes: Int = 0
    var ass: String = ""
    /// IDFV
    var gun: String = ADTool.shared.getIDFV()
    /// IDFA
    var shot: String = ADTool.shared.getIDFA()
    /// 经度
    var cobra: String = ""
    /// 纬度
    var cleared: String = ""
    /// 开始时间
    var jackal: Int = 0
    /// 结束时间
    var giftdrawn: Int = 0
    /// 混淆字段
    var needle: String = randomUUIDString()
}
