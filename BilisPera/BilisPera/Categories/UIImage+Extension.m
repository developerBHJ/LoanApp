//
//  UIImage+Extension.m
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (NSData *)compressImage:(UIImage *)image
               maxSizeKB:(NSInteger)maxSizeKB
          maxResolution:(CGFloat)maxResolution {
    // 第一步：智能尺寸压缩
    UIImage *resizedImage = [self resizeIfNeeded:image maxLength:maxResolution];
    // 第二步：动态质量压缩
    return [self binaryQualityCompression:resizedImage maxSizeKB:maxSizeKB];
}

#pragma mark - 私有方法

/// 图像尺寸压缩（如果需要）
/// @param image 原始图片
/// @param maxLength 最大边长(像素)
+ (UIImage *)resizeIfNeeded:(UIImage *)image maxLength:(CGFloat)maxLength {
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    // 无需调整的情况
    if (width <= maxLength && height <= maxLength) {
        return image;
    }
    
    // 计算压缩比例和新尺寸
    CGFloat ratio = MIN(maxLength/width, maxLength/height);
    CGSize newSize = CGSizeMake(width * ratio, height * ratio);
    
    // 创建新的图像上下文
    UIGraphicsBeginImageContextWithOptions(newSize, NO, image.scale);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ?: image;
}

/// 二分法质量压缩
/// @param image 待压缩图片
/// @param maxSizeKB 最大文件大小(KB)
+ (NSData *)binaryQualityCompression:(UIImage *)image maxSizeKB:(NSInteger)maxSizeKB {
    NSInteger maxSizeBytes = maxSizeKB * 1024;
    CGFloat compression = 1.0;
    
    // 初始压缩尝试
    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    if (!compressedData || compressedData.length <= maxSizeBytes) {
        return compressedData;
    }
    
    // 二分法渐进压缩（最多6次迭代）
    CGFloat minQuality = 0;
    CGFloat maxQuality = 1;
    NSData *data = compressedData;
    
    while (data.length >= maxSizeBytes) {
        compression = (maxQuality + minQuality) / 2;
        data = UIImageJPEGRepresentation(image, compression) ?: [NSData data];
        
        if (data.length < maxSizeBytes) {
            minQuality = compression;
        } else {
            maxQuality = compression;
        }
    }
    return data.length <= maxSizeBytes ? data : nil;
}

@end
