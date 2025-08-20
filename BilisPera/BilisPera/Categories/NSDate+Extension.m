//
//  NSDate+Extension.m
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSDate *)dateFromString:(NSString *)timeString withFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat ?: @"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"]];
    return [dateFormatter dateFromString:timeString];
}

@end
