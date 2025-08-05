//
//  TrackAPI.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/20.
//

import Foundation
import Moya

enum TrackAPI {
    case trackLocationInfo(dic: [String: Any])
    case trackGoogleMarket(dic: [String: Any])
    case trackRiskInfo(dic: [String: Any])
    case trackDeviceInfo(dic: [String: Any])
    case trackContacts(dic: [String: Any])
    case trackAPNSToken(dic: [String: Any])
}

extension TrackAPI: TargetType{
    var baseURL: URL {
        return URL.init(string: kApiHost)!
    }
    
    var path: String {
        switch self {
        case .trackLocationInfo:
            return "/bluesky/certain"
        case .trackGoogleMarket:
            return "/bluesky/indicated"
        case .trackRiskInfo:
            return "/bluesky/nervous"
        case .trackDeviceInfo:
            return "/bluesky/exact"
        case .trackContacts:
            return "/bluesky/little"
        case .trackAPNSToken:
            return "/bluesky/right"
        }
    }
    
    var method: Moya.Method {
        .post
    }
    
    var task: Moya.Task {
        switch self {
        case .trackLocationInfo(let dic):
            var bodayData = dic
            bodayData["extraordinary"] = randomUUIDString()
            bodayData["drama"] = randomUUIDString()
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .trackGoogleMarket(let dic):
            var bodayData = dic
            bodayData["action"] = randomUUIDString()
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .trackRiskInfo(let dic):
            var bodayData = dic
            bodayData["needle"] = randomUUIDString()
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .trackDeviceInfo(let dic):
            var bodayData = dic
            bodayData["needle"] = randomUUIDString()
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .trackContacts(let dic):
            var bodayData = dic
            bodayData["heart"] = randomUUIDString()
            bodayData["paralysis"] = randomUUIDString()
            return .requestCompositeParameters(bodyParameters: bodayData, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        case .trackAPNSToken(let dic):
            return .requestCompositeParameters(bodyParameters: dic, bodyEncoding: URLEncoding.httpBody, urlParameters: PublicParamas())
        }
    }
    
    var headers: [String : String]? {
        PublicHeader()
    }
}
