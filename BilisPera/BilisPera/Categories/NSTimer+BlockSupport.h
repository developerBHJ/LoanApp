//
//  NSTimer+BlockSupport.h
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (BlockSupport)

+ (NSTimer *)bp_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;


@end

NS_ASSUME_NONNULL_END
