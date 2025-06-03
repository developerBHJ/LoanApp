//
//  ProductAPI.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/23.
//

import Foundation
import Moya

enum ProductAPI {
    case apply(disappointed: String)
    case getProductDetail(disappointed: String)
    case getAuthenInfo(disappointed: String)
    case saveAuthenInfo(body: [String:Any])
    case getBasicInfo(disappointed: String)
    case getAddressList
    case saveBasicInfo(body: [String: Any])
    case getWorkInfo(disappointed: String)
    case saveWorkInfo(body: [String: Any])
    case getContactsInfo(disappointed: String)
    case saveContactsInfo(body:[String: Any])
    case getBankInfo(wilson: String)
    case getBankList
    case saveBankInfo(body: [String: Any])
}

extension ProductAPI: TargetType{
    var baseURL: URL {
        return URL.init(string: kApiHost)!
    }
    
    var path: String {
        switch self {
        case .apply:
            return "/bluesky/youre"
        case .getProductDetail:
            return "/bluesky/alibialibi"
        case .getAuthenInfo:
            return "/bluesky/leaned"
        case .saveAuthenInfo:
            return "/bluesky/fresh"
        case .getBasicInfo:
            return "/bluesky/deplored"
        case .getAddressList:
            return "/bluesky/address"
        case .saveBasicInfo:
            return "/bluesky/reporters"
        case .getWorkInfo:
            return "/bluesky/searched"
        case .saveWorkInfo:
            return "/bluesky/asleep"
        case .getContactsInfo:
            return "/bluesky/decided"
        case .saveContactsInfo:
            return "/bluesky/roomi"
        case .getBankInfo:
            return "/bluesky/truth"
        case .getBankList:
            return "/bluesky/frowned"
        case .saveBankInfo:
            return "/bluesky/having"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAuthenInfo,.getAddressList,.getBankInfo:
            return .get
        default:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .apply(let disappointed):
            var bodayData: [String: String] = [:]
            bodayData["disappointed"] = disappointed
            bodayData["gloomy"] = randomUUIDString()
            bodayData["waitress"] = randomUUIDString()
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .getProductDetail(let disappointed):
            var bodayData: [String: String] = [:]
            bodayData["disappointed"] = disappointed
            bodayData["coolness"] = randomUUIDString()
            bodayData["accentuate"] = randomUUIDString()
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .getAuthenInfo(let disappointed):
            var bodayData: [String: Any] = PublicParamas()
            bodayData["disappointed"] = disappointed
            bodayData["cool"] = randomUUIDString()
            return .requestParameters(parameters: bodayData, encoding: URLEncoding.default)
        case .saveAuthenInfo(let body):
            var bodayData = body
            bodayData["retreating"] = randomUUIDString()
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .getBasicInfo(let disappointed):
            var bodayData: [String: String] = [:]
            bodayData["disappointed"] = disappointed
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .getAddressList:
            return .requestPlain
        case .saveBasicInfo(let body):
            var bodayData = body
            bodayData["condole"] = randomUUIDString()
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .getWorkInfo(let disappointed):
            var bodayData: [String: String] = [:]
            bodayData["disappointed"] = disappointed
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .saveWorkInfo(let body):
            var bodayData = body
            bodayData["porrott"] = randomUUIDString()
            bodayData["loud"] = randomUUIDString()
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .getContactsInfo(let disappointed):
            var bodayData: [String: String] = [:]
            bodayData["disappointed"] = disappointed
            bodayData["glove"] = randomUUIDString()
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .saveContactsInfo(let body):
            return .requestCompositeParameters(bodyParameters: body, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .getBankInfo(let wilson):
            var bodayData: [String: Any] = PublicParamas()
            bodayData["wilson"] = wilson
            bodayData["notes"] = randomUUIDString()
            return .requestParameters(parameters: bodayData, encoding: URLEncoding.default)
        case .getBankList:
            return .requestPlain
        case .saveBankInfo(let body):
            var bodayData = body
            bodayData["everyone"] = randomUUIDString()
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        }
    }
    
    var headers: [String : String]? {
        PublicHeader()
    }
}
