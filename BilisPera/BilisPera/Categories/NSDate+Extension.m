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

- (NSInteger)currentYear {
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitYear fromDate:currentDate];
    return dateComponent.year ?: 0;
}

- (NSInteger)currentMonth {
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitMonth fromDate:currentDate];
    return dateComponent.month ?: 1;
}

- (NSInteger)currentDay {
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:NSCalendarUnitDay fromDate:currentDate];
    return dateComponent.day ?: 1;
}

+ (NSString *)currentTimeWithFormatter:(NSString *)formatter {
    if (!formatter) {
        formatter = @"YYYY-MM-dd HH:mm:ss";
    }
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter stringFromDate:currentDate];
}

+ (NSInteger)daysInMonthWithYear:(NSInteger)year month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = year;
    dateComponents.month = month;
    
    NSDate *date = [calendar dateFromComponents:dateComponents];
    if (date) {
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
        return range.length;
    }
    return 0;
}

@end
