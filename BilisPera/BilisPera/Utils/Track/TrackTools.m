//
//  TrackTools.m
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import "TrackTools.h"
#import <CoreLocation/CoreLocation.h>
#import "FBSDKCoreKit/FBSDKCoreKit.h"
#import "TrackDeviceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrackTools ()

@property (nonatomic,
           strong) NSMutableDictionary<NSNumber *,NSMutableDictionary<NSString *,NSNumber *> *> *trackTime;
@property (nonatomic, assign) CLLocationCoordinate2D defaultCoordinate;
@property (nonatomic, strong) TrackDeviceModel *deviceModel;

@end

@implementation TrackTools

+ (instancetype)shared {
    static TrackTools *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[TrackTools alloc] init];
    });
    return _shared;
}

-(void)configData{
    self.defaultCoordinate = CLLocationCoordinate2DMake(0, 0);
    self.latitude = 0;
    self.longitude = 0;
    self.deviceModel = [[TrackDeviceModel alloc] init];
}

-(NSInteger)registerStartTime{
    NSNumber *key = [NSNumber numberWithInteger:BPTrackRiskTypeRegister];
    return self.trackTime[key][@"startTime"].integerValue ?: 0;
}

-(NSInteger)getTrackTime:(BPTrackRiskType)type start:(BOOL)start{
    NSNumber *key = [NSNumber numberWithInteger:type];
    NSString *subKey = start ? @"startTime" : @"endTime";
    return self.trackTime[key][subKey].integerValue ?: 0;
}

-(void)saveTrackTime:(BPTrackRiskType)type start:(BOOL)start{
    NSNumber *key = [NSNumber numberWithInteger:type];
    NSString *subKey = start ? @"startTime" : @"endTime";
    NSNumber *time = [NSNumber numberWithInteger:[[NSDate date] timeIntervalSince1970]];
    if (self.trackTime[key]) {
        NSMutableDictionary *dic = self.trackTime[key];
        dic[subKey] = time;
        self.trackTime[key] = dic;
    }else{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];;
        dic[subKey] = time;
        self.trackTime[key] = dic;
    }
}

// 重置注册时间
-(void)resetRegisterTrackTime{
    NSNumber *key = [NSNumber numberWithInteger:BPTrackRiskTypeRegister];
    [self.trackTime removeObjectForKey:key];
}

- (void)trackForGoogleMarket{
    NSMutableDictionary *paramas = [[NSMutableDictionary alloc] init];
    paramas[@"meat"] = [NSString randomString];
    paramas[@"fresh"] = [[ADTool shared] idfvString];
    paramas[@"nd"] = [[ADTool shared] idfaString];
    kWeakSelf;
    [[HttpManager shared] requestWithService:GoogleMarket parameters:paramas showLoading:NO showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        [weakSelf registerFaceBook:response.couldsee[@"abruised"]];
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
    }];
}

-(void)registerFaceBook:(NSDictionary *)paramas{
    [FBSDKSettings sharedSettings].appID = [NSString stringWithFormat:@"%@",
                                            paramas[@"firegladdened"]];
    [FBSDKSettings sharedSettings].appURLSchemeSuffix = [NSString stringWithFormat:@"%@",
                                                         paramas[@"hadhad"]];
    [FBSDKSettings sharedSettings].displayName = [NSString stringWithFormat:@"%@",
                                                  paramas[@"joyful"]];
    [FBSDKSettings sharedSettings].clientToken = [NSString stringWithFormat:@"%@",
                                                  paramas[@"inless"]];
    [[FBSDKApplicationDelegate sharedInstance] application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:nil];
}


@end

NS_ASSUME_NONNULL_END
