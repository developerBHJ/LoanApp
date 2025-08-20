//
//  CGFloat+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/12.
//

import Foundation
import UIKit


@MainActor
let kScreenW = UIScreen.main.bounds.size.width
@MainActor
let kScreenH = UIScreen.main.bounds.size.height

@MainActor
let kRatio = CGFloat( kScreenW / 375)


extension CGFloat{
    @MainActor
    func ratio() -> CGFloat{
        return CGFloat(ceil(self * kRatio))
    }
}

extension Int{
    @MainActor
    func ratio() -> Int{
        return Int(ceil(CGFloat(self) * kRatio))
    }
}

extension Double{
    @MainActor
    func ratio() -> Double{
        return ceil(CGFloat(self) * kRatio)
    }
}
