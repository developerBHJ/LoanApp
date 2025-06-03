//
//  PersonalBasicModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/27.
//

import Foundation
struct PersonalBasicModel: BaseModel {
    var confidential: Int = 0
    var feel: String = ""
    var tea: String = ""
    /// item的唯一标识（用于保存的时候作为 key）
    var article: String = ""
    /// 表单item类型 （单选框，输入框，地区选择框)
    var bow:  ProductFormType = .text
    /// 键盘类型，输入框需要用到（0 为全键盘，1 为数字键盘）
    var clear: Int = 0
    /// 单选框的选项数组
    var definitely: [ProductFormItem]? = nil
    var flush: Int = 0
    var late: Int = 0
    var mind: String = ""
    var sympathy: Bool = false
    /// value 展示或回显用
    var laughed: String = ""
    /// key   保存时传参用
    var general: String = ""
    var laugh: Int = 0
}

struct ProductFormItem: BaseModel {
    /// 单选框的值,用于显示和回显
    var nowadays: String = ""
    /// 单选框的key，用于保存时传参
    var general: String = ""
    /// 图标
    var consulted: String = ""
}

struct ProductEditItem: BaseModel {
    var key: String = ""
    var value: String = ""
    /// 单选框的key，用于保存时传参
    var general: String = ""
}
