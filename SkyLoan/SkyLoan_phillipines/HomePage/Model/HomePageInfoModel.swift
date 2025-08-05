//
//  HomePageInfoModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/20.
//

import Foundation
import SmartCodable

enum HomePageGeneral: String,BaseEnum {
    case BANNER = "nicebluea"
    case LARGE = "niceblueb"
    case SMELL = "nicebluec"
    case REPAY = "niceblued"
    case PRODUCT_LIST = "nicebluee"
}

struct HomePageInfoModel: BaseModel {
    /// 强制定位字段：1强制，0不强制
    var deed: Int = 0
    /// 首页差异化模块显示状态，1表示显示，0表示不显示
    var murdering: Int = 0
    /// 联系我们模块
    var sometimes: HomePageItem? = nil
    /// banner
    var anybody:Anybody<HomePageItem>? = nil
    /// 预期提醒
    var romantic: Anybody<HomePageItem>? = nil
    /// 产品列表
    var comic: Anybody<HomeProductModel>? = nil
    /// 大卡位 或 小卡位
    var romance: Anybody<HomeProductModel>? = nil
}

struct Anybody<T:BaseModel>: BaseModel {
    var general: HomePageGeneral? = nil
    var winning: [T]?
}

struct HomePageItem: BaseModel {
    /// 跳转地址
    var somehow: String = ""
    /// 图片
    var hair: String = ""
    /// 文案
    var wondered: String = ""
    
    /// 图片
    var earnestly: String = ""
    /// 跳转地址
    var gazing: String = ""
}
