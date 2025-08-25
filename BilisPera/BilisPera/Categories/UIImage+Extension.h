//
//  UIImage+Extension.h
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

+ (NSData *)compressImage:(UIImage *)image
               maxSizeKB:(NSInteger)maxSizeKB
            maxResolution:(CGFloat)maxResolution;

@end

NS_ASSUME_NONNULL_END
