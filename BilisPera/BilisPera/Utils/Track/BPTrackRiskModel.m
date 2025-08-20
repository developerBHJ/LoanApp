//
//  BPTrackRiskModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import "BPTrackRiskModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPTrackRiskModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.andto = @"";
        self.loud = [NSString randomString];
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
