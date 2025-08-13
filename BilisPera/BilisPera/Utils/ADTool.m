//
//  ADTool.m
//  BilisPera
//
//  Created by BHJ on 2025/8/6.
//

#import "ADTool.h"
#import "KeychainWrapper.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ADTool

+ (instancetype)shared {
    static ADTool *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[ADTool alloc] init];
    });
    return _shared;
}

- (instancetype)init {
    if (self = [super init]) {
        _idfvString = [[[UIDevice currentDevice] identifierForVendor] UUIDString] ?: @"";
        _idfaString = @"";
        _trackCount = 0;
    }
    return self;
}

- (void)registerIDFAAndTrack {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __weak typeof(self) weakSelf = self;
        [self registerIDFAWithCompletion:^(BOOL success) {
            if (weakSelf.trackCount < 2) {
                [[TrackTools shared] trackForGoogleMarket];
                weakSelf.trackCount += 1;
            }
        }];
    });
}

- (void)registerIDFAWithCompletion:(void(^)(BOOL success))completion {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                switch (status) {
                    case ATTrackingManagerAuthorizationStatusAuthorized: {
                        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
                        ADTool.shared.idfaString = idfa;
                        NSData *idfvData = [self.idfvString dataUsingEncoding:NSUTF8StringEncoding];
                        if (idfvData) {
                            [KeychainWrapper saveWithKey:@"IDFV" data:idfvData];
                        }
                        if (completion) completion(YES);
                        break;
                    }
                    case ATTrackingManagerAuthorizationStatusNotDetermined:
                        [self registerIDFAWithCompletion:completion];
                        break;
                    default:
                        if (completion) completion(NO);
                        break;
                }
            });
        }];
    } else {
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
            self.idfaString = idfa;
            
            NSData *idfvData = [self.idfvString dataUsingEncoding:NSUTF8StringEncoding];
            if (idfvData) {
                [KeychainWrapper saveWithKey:@"IDFV" data:idfvData];
            }
            if (completion) completion(YES);
        } else {
            if (completion) completion(NO);
        }
    }
}

@end

NS_ASSUME_NONNULL_END
