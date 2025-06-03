//
//  LoginAPI.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/20.
//

import Foundation
import Moya

enum LoginAPI {
    case getVerifyCode(pay: String)
    case login(dic: [String: Any])
    case loginOut
    case loginOff
}

extension LoginAPI: TargetType{
    var baseURL: URL {
        return URL.init(string: kApiHost)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/bluesky/going"
        case .getVerifyCode:
            return "/bluesky/noticed"
        case .loginOut:
            return "/bluesky/matters"
        case .loginOff:
            return "/bluesky/allowed"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getVerifyCode,.login:
            return .post
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login(let dic):
            var bodayData = dic
            bodayData["lifted"] = randomUUIDString()
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .getVerifyCode(let pay):
            let bodayData = ["pay": pay,"thanks":randomUUIDString()] as [String : Any]
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .loginOut:
            var bodayData = PublicParamas()
            bodayData["conversation"] = randomUUIDString()
            bodayData["unsympathetic"] = randomUUIDString()
            return .requestParameters(parameters: bodayData, encoding: URLEncoding.default)
        case .loginOff:
            var bodayData = PublicParamas()
            bodayData["attitude"] = randomUUIDString()
            return .requestParameters(parameters: bodayData, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        PublicHeader()
    }
    
    var sampleData: Data{
        Data()
    }
    
    func jsonToData(dic: [String: Any]) -> Data{
        let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
        return data ?? Data()
    }
}

