//
//  UITableViewCell+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/15.
//

import UIKit


extension UITableViewCell{
    static private var dataKey = "dataKey"
    
    static var reusableId: String{
        NSStringFromClass(Self.self)
    }
    
    var data: Any?{
        set{
            if let value = newValue{
                objc_setAssociatedObject(self, &UITableViewCell.dataKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            configData(data: newValue)
        }
        get{
            objc_getAssociatedObject(self, &UITableViewCell.dataKey)
        }
    }
}
