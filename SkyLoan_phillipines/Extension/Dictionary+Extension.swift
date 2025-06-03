//
//  Dictionary+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/23.
//

import Foundation

extension Dictionary{
    func toURLStrings() -> String{
        var components = URLComponents()
        components.queryItems = self.map({URLQueryItem(name: "\($0.key)", value: "\($0.value)")})
        return components.percentEncodedQuery ?? ""
    }
}

extension Array where Element == UInt8 {
    func toBase64() -> String {
        return Data(self).base64EncodedString()
    }
}

extension Array where Element: LosslessStringConvertible {
    func toBase64String() -> String? {
        let string = self.map { String($0) }.joined(separator: ",")
        return string.data(using: .utf8)?.base64EncodedString()
    }
}

