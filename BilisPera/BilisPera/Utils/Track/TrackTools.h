//
//  TrackTools.h
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import <Foundation/Foundation.h>
#import "CoreLocation/CoreLocation.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,BPTrackRiskType) {
    BPTrackRiskTypeRegister = 1,
    BPTrackRiskTypeAuthenSelect = 2,
    BPTrackRiskTypeIdInfo= 3,
    BPTrackRiskTypeFaceId = 4,
    BPTrackRiskTypeBasicInfo = 5,
    BPTrackRiskTypeWorkInfo = 6,
    BPTrackRiskTypeContacts = 7,
    BPTrackRiskTypeReceipt = 8,
    BPTrackRiskTypeApply = 9,
    BPTrackRiskTypeFinish = 10,
};

@interface TrackTools : NSObject

+ (instancetype)shared;
/// app启动时间
@property (nonatomic, assign) NSInteger launchTime;
/// 上次登录时间，毫秒数
@property (nonatomic, assign) NSInteger lastLoginTime;
// 纬度
@property (nonatomic, assign) double longitude;
// 经度
@property (nonatomic, assign) double latitude;

@property (nonatomic, assign, readonly) NSInteger registerStartTime;

-(void)configData;
// 保存埋点时间
-(void)saveTrackTime:(BPTrackRiskType)type start:(BOOL)start;
// 获取埋点时间
-(NSInteger)getTrackTime:(BPTrackRiskType)type start:(BOOL)start;


-(void)trackForGoogleMarket;

-(void)trackLocation;

-(void)trackDeviceInfo;

-(void)trackContactsInfo:(NSDictionary *)paramas;

-(void)trackRiskInfo:(BPTrackRiskType)type productId:(NSString *)productId;

@end

NS_ASSUME_NONNULL_END
