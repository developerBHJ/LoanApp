//
//  CGFloat+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/12.
//

import Foundation

extension CGFloat{
    func ratio() -> CGFloat{
        return CGFloat(ceil(self * kRatio))
    }
}

extension Int{
    func ratio() -> Int{
        return Int(ceil(CGFloat(self) * kRatio))
    }
}

extension Double{
    func ratio() -> Double{
        return ceil(CGFloat(self) * kRatio)
    }
}
