//
//  ProductInfoModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/25.
//

import Foundation

enum VertifyType: String, BaseEnum{
    case none
    case DRIVINGLICENSE
    case PRC
    case SSS
    case PASSPORT
    case POSTALID
    case UMID
    case TIN
    case VOTERID
    case NATIONALID
    case PAGIBIG
    case HEALTHCARD
}

struct ProductInfoModel:BaseModel {
    var physically: PhysicallyModel?
    var strenuous: StrenuousModel?
    /// 人脸是否完成 0否1是  "B"
    var `false`: Int = 0
    /// 人脸图片地址
    var somehow: String = ""
    /// ocr 证件类型列表
    var detectives: [[VertifyType]] = []
    /// 图片选择类型：1，相机+相册；2，相机
    var general: Int = 0
}

struct PhysicallyModel:BaseModel {
}
struct StrenuousModel:BaseModel {
    /// 证件是否完成 0否1是
    var late: Int = 0
    /// 证件图片地址
    var somehow: String = ""
    /// 已选卡片类型
    var less: VertifyType = .none
    /// 身份信息
    var psychologically: PsychologicallyModel?
}

struct PsychologicallyModel:BaseModel {
    /// 姓名
    var nowadays: String = ""
    /// 身份证
    var date: String = ""
    /// 生日
    var stuff: String = ""
    /// 性别
    var detecting: String = ""
    var somehow: String = ""
    var calls: String = ""
    var es: String = ""
    var beggar: String = ""
}
