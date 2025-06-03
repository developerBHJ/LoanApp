//
//  ContactsModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/28.
//

import Foundation
struct ContactsModel: BaseModel {
    /// 当前 item 选中的关系 key（回显的时候会用到）
    var foreigners: String = ""
    /// 当前 item 联系人的姓名（用于回显）
    var nowadays: String = ""
    /// 当前 item 联系人的电话（用于回显）
    var belgian: String = ""
    /// 当前 item 的标识 number（用于保存数据）
    var satisfied: String = ""
    /// 当前 item 的标题 （用于显示)
    var rested: String = ""
    ///  选择关系的title（图片或文案）（用于显示）
    var gaze: String = ""
    ///  选择关系的提示 （用于显示）
    var transferred: String = ""
    ///  选择号码的title（图片或文案）（用于显示）
    var times: String = ""
    ///  选择号码的提示（用于显示）
    var several: String = ""
    ///  关系选项的列表
    var collaborated: [ProductFormItem] = []
}
