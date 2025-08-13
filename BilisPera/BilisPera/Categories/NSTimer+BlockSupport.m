//
//  NSTimer+BlockSupport.m
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import "NSTimer+BlockSupport.h"

@implementation NSTimer (BlockSupport)

+ (NSTimer *)bp_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(bp_callBlock:) userInfo:[block copy] repeats:repeats];
}

+ (void)bp_callBlock:(NSTimer *)timer {
    void (^block)(NSTimer *timer) = timer.userInfo;
    !block ?: block(timer);
}

@end
