//
//  BaseModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/19.
//

import Foundation
import SmartCodable

public protocol Serializable {
    init()
    func toJson() -> [String: Any]?
    func toJSONString(prettyPrint: Bool) -> String?
}

extension Serializable{
    static func model(from json: String,designatedPath: String? = nil) -> Self{
        if let type = Self.self as? BaseModel.Type{
            let model = type.model(from: json, designatedPath: designatedPath)
            return model as! Self
        }
        return Self()
    }
    
    static func model(from dict: [String : Any],designatedPath: String? = nil) -> Self{
        if let type = Self.self as? BaseModel.Type{
            let model = type.model(from: dict, designatedPath: designatedPath)
            return model as! Self
        }
        return Self()
    }
    
    static func modelArray(from list: [[String: Any]],designatedPath: String? = nil) -> [Self]{
        if let type = Self.self as? BaseModel.Type{
            let list = type.modelArray(from: list, designatedPath: designatedPath)
            return list as! [Self]
        }
        return []
    }
}

public protocol BaseModel: Serializable,SmartCodable{}
public protocol BaseEnum: SmartCaseDefaultable{}

extension BaseModel{
    static func model(from json: String,designatedPath: String? = nil) -> Self{
        Self.deserialize(from: json,designatedPath: designatedPath) ?? Self()
    }
    
    static func model(from dict: [String: Any],designatedPath: String? = nil) -> Self{
        Self.deserialize(from: dict,designatedPath: designatedPath) ?? Self()
    }
    
    static func modelArray(from list: [[String: Any]],designatedPath: String? = nil) -> [Self]{
        [Self].deserialize(from: list,designatedPath: designatedPath) ?? []
    }
}

extension BaseModel{
    public func toJson() -> [String : Any]? {
        nil
    }
    
    public func toJSONString(prettyPrint: Bool) -> String? {
        nil
    }
}
