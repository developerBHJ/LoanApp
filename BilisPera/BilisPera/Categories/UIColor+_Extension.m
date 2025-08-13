//
//  UIColor+_Extension.m
//  BilisPera
//
//  Created by BHJ on 2025/8/5.
//

#import "UIColor+_Extension.h"

@implementation UIColor (_Extension)

+(UIColor *)colorWithHexString:(NSString *)hexString{
    return [self colorWithHexString:hexString alpha:1.0];
}

+(UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha{
    NSString* colorString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ] uppercaseString];
    if ([colorString hasPrefix:@"#"]) {
        colorString = [colorString substringFromIndex:1];
    }else if([colorString hasPrefix:@"0x"]){
        colorString = [colorString substringFromIndex:2];
    }
    if (colorString.length != 6 && colorString.length != 8) {
        return  [UIColor clearColor];
    }
    NSRange range = NSMakeRange(0, 2);
    NSString *rString = [colorString substringWithRange:range];
    range.location = 2;
    NSString *gString = [colorString substringWithRange:range];
    range.location = 4;
    NSString *bString = [colorString substringWithRange:range];
        
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1.0f];
}
+(UIColor *)colorWithHex:(UInt32)hex{
    return [self colorWithHex:hex alpha:1.0];
}

+(UIColor *)colorWithHex:(UInt32 )hex alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((hex >> 16) & 0xFF) / 255.0 green:((hex >> 8) & 0xFF) / 255.0 blue:(hex & 0xFF) / 255.0 alpha:alpha];
}

@end
