//
//  UIImage+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/21.
//

import UIKit

extension UIImage{
    
    func resizableImage(withCapInsets: UIEdgeInsets) -> UIImage?{
        let resizableImage = self.resizableImage(withCapInsets: withCapInsets, resizingMode: .stretch)
        return resizableImage
    }
    
    func stretchableCenter() -> UIImage {
        let insets = UIEdgeInsets(
            top: size.height/2 - 1,
            left: size.width/2 - 1,
            bottom: size.height/2 - 1,
            right: size.width/2 - 1
        )
        return resizableImage(withCapInsets: insets, resizingMode: .stretch)
    }
}

extension UIImage {
    func smartCompress(maxKB: Int) -> Data? {
        let maxLength = maxKB * 1024
        var compression: CGFloat = 1.0
        guard var data = self.jpegData(compressionQuality: compression) else { return nil }
        if data.count < maxLength { return data }
        var max: CGFloat = 1.0
        var min: CGFloat = 0.0
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = self.jpegData(compressionQuality: compression)!
            if CGFloat(data.count) < CGFloat(maxLength) * 0.9 {
                min = compression
            } else if data.count > maxLength {
                max = compression
            } else {
                break
            }
        }
        return data
    }
}
