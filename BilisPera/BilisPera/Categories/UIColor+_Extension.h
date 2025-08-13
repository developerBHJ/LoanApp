//
//  UIColor+_Extension.h
//  BilisPera
//
//  Created by BHJ on 2025/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (_Extension)

+(UIColor *)colorWithHexString:(NSString *)hexString;
+(UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
+(UIColor *)colorWithHex:(UInt32)hex;
+(UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
