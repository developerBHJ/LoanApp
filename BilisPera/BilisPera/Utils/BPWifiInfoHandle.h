//
//  BPWifiInfoHandle.h
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BPNetworkType) {
    NetworkTypeUnknown,
    NetworkTypeNotReachable,
    NetworkTypeWiFi,
    NetworkType2G,
    NetworkType3G,
    NetworkType4G,
    NetworkType5G
};

@interface BPWifiInfoHandle : NSObject
+ (BOOL)isSimulator;
+ (NSString *)getCurrentWifiSSid;
+ (NSString *)getCurrentWifiBSid;
+ (BOOL)isProxyEnabled;
+(BOOL)isVPNConnected;
+ (BOOL)checkSymbolicLink;
+ (NSString *)getDefaultCarrierName;
+ (BPNetworkType)currentNetworkType;
+ (NSString *)currentNetworkTypeString;
+ (NSString *)getLocalIPAddress;
+(BOOL)isReachable;

@end

NS_ASSUME_NONNULL_END
