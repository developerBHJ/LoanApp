//
//  API.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/19.
//

import Moya

func PublicHeader() -> [String:String]{
    var headerDic = [String:String]()
    headerDic["Content-Type"] = "application/x-www-form-urlencoded"
    //    headerDic["Content-Type"] = "Content-Type:application/json"
    return headerDic
}

func PublicParamas() -> [String: String]{
    var tempDic = [String:String]()
    tempDic["gray"] = "ios"
    tempDic["frenchman"] = appVersion
    tempDic["elderly"] = deviceName
    tempDic["tall"] = ADTool.shared.getIDFV()
    tempDic["called"] = sysVersion
    tempDic["witness"] = "skyloanapi"
    tempDic["witness"] = "skyloanapi"
    tempDic["crowded"] = LoginTool.shared.getToken()
    tempDic["court"] = ADTool.shared.getIDFV()
    tempDic["boyfine"] = randomUUIDString()
    return tempDic
}
