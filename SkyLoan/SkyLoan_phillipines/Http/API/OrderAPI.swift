//
//  OrderAPI.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/22.
//

import Foundation
import Moya

enum OrderAPI {
    case orderList(present: String)
    case getOrderDetail(counting: String)
}

extension OrderAPI: TargetType{
    var baseURL: URL {
        return URL.init(string: kApiHost)!
    }
    
    var path: String {
        switch self {
        case .orderList:
            return "/bluesky/cases"
        case .getOrderDetail:
            return "/bluesky/soberlyits"
        }
    }
    
    var method: Moya.Method {
        .post
    }
    
    var task: Moya.Task {
        switch self {
        case .orderList(let present):
            var bodayData: [String: String] = [:]
            bodayData["present"] = present
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .getOrderDetail(let counting):
            var bodayData: [String: String] = [:]
            bodayData["counting"] = counting
            bodayData["audacity"] = randomUUIDString()
            bodayData["unparalleled"] = randomUUIDString()
            bodayData["abandoned"] = randomUUIDString()
            bodayData["desperate"] = randomUUIDString()
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        }
    }
    
    var headers: [String : String]? {
        PublicHeader()
    }
}
