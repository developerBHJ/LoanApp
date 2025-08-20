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

@end
