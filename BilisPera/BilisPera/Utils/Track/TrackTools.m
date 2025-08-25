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
#import "BPTrackRiskModel.h"
#import "BPADTools.h"
#import "BPLocationManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrackTools ()

@property (nonatomic,
           strong) NSMutableDictionary<NSNumber *,NSMutableDictionary<NSString *,NSNumber *> *> *trackTime;

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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.trackTime = [[NSMutableDictionary alloc] init];
        [self registerStartTime];
        self.lastLoginTime = 0;
        self.launchTime = 0;
        self.latitude = 0;
        self.longitude = 0;
    }
    return self;
}

-(void)configData{
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
    paramas[@"fresh"] = [[BPADTools shared] getIDFV];
    paramas[@"nd"] = [[BPADTools shared] getIDFA];
    kWeakSelf;
    NSLog(@"%@",paramas);
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

-(void)trackLocation{
    [[BPLocationManager shared] startLocationRequestWithCompletion:^{
        BPLocationModel *model = [[BPLocationManager shared] getUserLocation];
        if (model) {
            NSDictionary  *paramas = model.mj_keyValues;
            [[HttpManager shared] requestWithService:UploadLocation parameters:paramas showLoading:NO showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
                    
            } failure:^(NSError * _Nonnull error,
                        NSDictionary * _Nonnull errorDictionary) {
                    
            }];
        }
    }];
}

-(void)trackDeviceInfo{
    TrackDeviceModel *model = [[TrackDeviceModel alloc] init];
    NSDictionary *paramas = model.mj_keyValues;
    NSString *json = [NSData objectToBase64JSONString:paramas];
    NSDictionary *dic = @{@"couldsee" : json};
    [[HttpManager shared] requestWithService:UploadDeviceInfo parameters:dic showLoading:NO showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
            
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
            
    }];
}

-(void)trackContactsInfo:(NSDictionary *)paramas{
    [[HttpManager shared] requestWithService:UploadContacts parameters:paramas showLoading:NO showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
            
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
            
    }];
}

-(void)trackRiskInfo:(BPTrackRiskType)type productId:(NSString *)productId{
    [[BPLocationManager shared] startLocationRequestWithCompletion:^{
        NSMutableDictionary *paramas = [[NSMutableDictionary alloc] init];
        BPTrackRiskModel *model = [self configRiskTrackData:type productId:productId];
        paramas = model.mj_keyValues;
        [[HttpManager shared] requestWithService:UploadRiskInfo parameters:paramas showLoading:NO showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
            if (type == BPTrackRiskTypeRegister) {
                [self resetRegisterTrackTime];
            }
        } failure:^(NSError * _Nonnull error,
                    NSDictionary * _Nonnull errorDictionary) {
                
        }];
    }];
}

-(BPTrackRiskModel *)configRiskTrackData:(BPTrackRiskType) type productId:(NSString *)productId{
    BPTrackRiskModel *model = [[BPTrackRiskModel alloc] init];
    model.myinexperience = productId;
    model.instincts = [NSString stringWithFormat:@"%ld",type];
    model.superior =  [[BPADTools shared] getIDFV];
    model.reins =  [[BPADTools shared] getIDFA];
    BPLocationModel *location = [[BPLocationManager shared] getUserLocation];
    if (location) {
        model.sighted = location.sighted;
        model.hills = location.hills;
    }
    model.trail = [NSString stringWithFormat:@"%ld",
                   [self getTrackTime:type start:YES]];
    model.neigh = [NSString stringWithFormat:@"%ld",
                   [self getTrackTime:type start:NO]];
    return model;
}


@end

NS_ASSUME_NONNULL_END
