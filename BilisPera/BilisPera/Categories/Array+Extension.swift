//
//  Array+Extension.swift
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

import Foundation

@objc extension NSArray{
    func firstWhere(block: @escaping (Any) -> Bool) -> Any? {
        return (self as Array).first(where: block)
    }
}
