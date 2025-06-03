//
//  Data+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/29.
//

import Foundation

extension Data{
    static func objectToData(paramas:Any?) -> Data {
        guard paramas != nil else {
            return Data()
        }
        guard JSONSerialization.isValidJSONObject(paramas!) else { return Data()}
        guard let data = try? JSONSerialization.data(withJSONObject: paramas!, options: [])else { return Data()}
        return data
    }
    
    static func objectToJSONString(paramas:Any?) -> String {
        let data = Data.objectToData(paramas: paramas)
        let jsonString = String.init(data: data, encoding: .utf8)
        return jsonString ?? ""
    }
}
