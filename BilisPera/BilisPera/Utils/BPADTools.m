//
//  BPADTools.m
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import "BPADTools.h"
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "BPKeyChainWrapper.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPADTools ()

@property (nonatomic, strong) NSString *idfvString;

@end

@implementation BPADTools

+ (instancetype)shared {
    static BPADTools *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[BPADTools alloc] init];
    });
    return _shared;
}

- (void)registerIDFAAndTrack {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __weak typeof(self) weakSelf = self;
        [self registerIDFAWithCompletion:^(BOOL success) {
            if (!success) return;
            if (weakSelf.trackCount < 2) {
                [[TrackTools shared] trackForGoogleMarket];
                weakSelf.trackCount += 1;
            }
        }];
    });
}

-(void)registerIDFAWithCompletion:(simpleBoolCompletion)completion{
    [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        if (status == ATTrackingManagerAuthorizationStatusNotDetermined) {
            [self registerIDFAWithCompletion:completion];
        }else if(status == ATTrackingManagerAuthorizationStatusAuthorized){
            self.idfvString = [[[UIDevice currentDevice] identifierForVendor] UUIDString] ?: @"";
            NSData *idfvData = [self.idfvString dataUsingEncoding:NSUTF8StringEncoding];
            if (idfvData) {
                [BPKeyChainWrapper saveData:idfvData forKey:@"IDFV"];
            }
            completion(YES);
        }else{
            completion(NO);
        }
    }];
}


-(NSString *)getIDFV{
    NSData *data = [BPKeyChainWrapper loadDataForKey:@"IDFV"];
    if (data) {
        NSString *idfvStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return idfvStr ?: @"";
    }
    return @"";
}

-(NSString *)getIDFA{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] ?: @"";
}

@end

NS_ASSUME_NONNULL_END
