//
//  UIImage+Extension.swift
//  BilisPera
//
//  Created by BHJ on 2025/8/21.
//

import UIKit

extension UIImage{
    
   @objc static func compress(
        image: UIImage,
        maxSizeKB: Int = 500,
        maxResolution: CGFloat = 2000
    ) -> Data? {
        // 第一步：智能尺寸压缩
        let resizedImage = resizeIfNeeded(
            image: image,
            maxLength: maxResolution
        )
        // 第二步：动态质量压缩
        return binaryQualityCompression(
            image: resizedImage,
            maxSizeKB: maxSizeKB
        )
    }
    
    private static func resizeIfNeeded(image: UIImage, maxLength: CGFloat) -> UIImage {
        let width = image.size.width
        let height = image.size.height
        // 无需调整的情况
        guard width > maxLength || height > maxLength else { return image }
        let ratio = min(maxLength/width, maxLength/height)
        let newSize = CGSize(width: width*ratio, height: height*ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? image
    }
    
    private static func binaryQualityCompression(image: UIImage, maxSizeKB: Int) -> Data? {
        let maxSizeBytes = maxSizeKB * 1024
        var compression: CGFloat = 1.0
        let compressedData = image.jpegData(compressionQuality: compression)
        guard var data = compressedData, data.count > maxSizeBytes else {
            return compressedData
        }
        // 二分法渐进压缩（最多6次迭代）
        var minQuality: CGFloat = 0
        var maxQuality: CGFloat = 1
        while data.count >= maxSizeBytes {
            compression = (maxQuality + minQuality) / 2
            data = image.jpegData(compressionQuality: compression) ?? Data()
            if data.count < maxSizeBytes {
                minQuality = compression
            } else {
                maxQuality = compression
            }
        }
        return data.count <= maxSizeBytes ? data : nil
    }
}
