//
//  TrackDeviceModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/6/3.
//

import Foundation

struct TrackDeviceModel:BaseModel {
    /// 系统类型
    var died: String = ""
    /// 系统版本
    var hyena: String = ""
    /// 上次登录时间，毫秒数
    var injecting: String = ""
    /// 包名
    var realized: String = ""
    /// 电池信息
    var virulence: Virulence = .init()
    /// general_data
    var effect:Effect = .init()
    /// hardware
    var trace: TraceModel = .init()
    /// network 网络模块
    var analyst: AnalystModel = .init()
    /// storage内存模块
    var dreamy: DreamyModel = .init()
}

struct Virulence: BaseModel {
    /// 电池百分比 传0~100内的int
    var intense: Int = 0
    /// 是否正在充电(yes: 1, no: 0)
    var human: Int = 0
}

struct Effect: BaseModel {
    /// idfv
    var paralyzing:String = ""
    /// idfa
    var acts:String = ""
    /// 设备mac ：取wifi里的bssid
    var existence:String = ""
    /// 系统当前时间，单位毫秒, 给int
    var poisonous:Int = 0
    /// 是否使用代理(yes:1,no:0)
    var deadly: Int = 0
    /// 是否使用VPN(yes:1,no:0)
    var snake: Int = 0
    /// 是否越狱
    var tree: Int = 0
    /// 是否是模拟器
    var boomslang: Int = 0
    /// 设备语言
    var typus: String = ""
    /// 设备运营商
    var dispholidus: String = ""
    /// 网络类型 2G/3G/4G/5G/WIFI/OTHER
    var venom: String = ""
    /// 时区的 ID  正确的值就是GMT+8这种
    var recently: String = ""
    /// 设备启动毫秒数，给int
    var according: Int = 0
}

struct TraceModel: BaseModel {
    /// 给空字符串
    var faintest: String = ""
    /// 设备名牌
    var gusto: String = ""
    /// 给空字符串
    var tribes: String = ""
    /// 设备高度 给int
    var used: Int = 0
    /// 设备宽度 给int
    var preparation: Int = 0
    /// 设备名称
    var dipped: String = ""
    /// 设备型号
    var sent: String = ""
    /// iPhone 原始设备型号
    var fatal: String = ""
    /// 物理尺寸 给 string
    var poisons: String = ""
    /// 系统版本
    var rare: String = ""
}

struct AnalystModel: BaseModel {
    /// 内网ip
    var government: String = ""
    /// wifi列表  把下面current_wifi放入这个数组即可
    var learn: [LearnModel] = []
    /// current_wifi
    var expression: LearnModel? = nil
    /// 取上面wifi列表里元素个数 或者 current_wifi有数据就传1
    var benignant: Int = 0
}

struct LearnModel: BaseModel {
    /// name
    var nowadays: String = ""
    /// bssid
    var shock: String = ""
    /// mac
    var existence: String = ""
    /// ssid
    var stupid: String = ""
}

struct DreamyModel: BaseModel {
    /// 未使用存储大小 给int
    var winterspoon: Int = 0
    /// 总存储大小 给int
    var wrote: Int = 0
    /// 总内存大小 给int
    var attentively: Int = 0
    /// 未使用内存大小 给int
    var instantaneous: Int = 0
}
