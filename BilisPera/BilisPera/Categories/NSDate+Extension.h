//
//  NSDate+Extension.h
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extension)

+ (NSDate *)dateFromString:(NSString *)timeString withFormat:(NSString *)dateFormat;

@end

NS_ASSUME_NONNULL_END
