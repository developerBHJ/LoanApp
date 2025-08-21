//
//  NSData+Extension.m
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import "NSData+Extension.h"

@implementation NSData (Extension)

+ (NSString *)objectToJSONString:(id)paramas {
    NSData *data = [NSJSONSerialization dataWithJSONObject:paramas
                                                  options:0
                                                    error:nil];
    if (!data) return @"";
    return [[NSString alloc] initWithData:data
                                encoding:NSUTF8StringEncoding] ?: @"";
}

+ (NSString *)objectToBase64JSONString:(id)paramas {
    NSString *jsonStr = [NSData objectToJSONString:paramas];
    NSString *base64Str = [[jsonStr dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
    return base64Str ?: @"";
}

@end
