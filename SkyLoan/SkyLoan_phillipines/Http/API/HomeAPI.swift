//
//  HomeAPI.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/20.
//

import Foundation
import Moya

enum HomeAPI {
    case homeInfo
}

extension HomeAPI: TargetType{
    var baseURL: URL {
        return URL.init(string: kApiHost)!
    }
    
    var path: String {
        "/bluesky/during"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        var bodayData: [String: Any] = PublicParamas()
        bodayData["deplored"] = randomUUIDString()
        bodayData["desirability"] = randomUUIDString()
        return .requestParameters(parameters: bodayData, encoding: URLEncoding.default)
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
