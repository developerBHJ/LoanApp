//
//  APIService.m
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import "APIService.h"

NS_ASSUME_NONNULL_BEGIN

@implementation APIService

+(NSString *)getUrlWith:(ServiceAPI)service{
    NSString *url = @"";
    switch (service) {
        case GetVerfyCode:
            url = @"/sudden/nottouched";
            break;
        case LoginAndRegister:
            url = @"/sudden/another";
            break;
        case GoogleMarket:
            url = @"/sudden/airand";
            break;
    }
    return [NSString stringWithFormat:@"%@%@?%@",kBaseUrl,url,[APIService pulicParmas].toURLStrings];
}

+(NetRequestType)getRequestType:(ServiceAPI)service{
    NetRequestType type = NetRequestType_POST;
    switch (service) {
        case GetVerfyCode:
            type = NetRequestType_POST;
            break;
        case LoginAndRegister:
            type = NetRequestType_POST;
            break;
        case GoogleMarket:
            type = NetRequestType_POST;
            break;
    }
    return type;
}

+(BPRequestContentType)contentType:(ServiceAPI)service{
    BPRequestContentType type = BPRequestContentTypeFormURLEncoded;
    switch (service) {
        case GetVerfyCode:
            type = BPRequestContentTypeFormURLEncoded;
            break;
        default:
            type = BPRequestContentTypeFormURLEncoded;
    }
    return type;
}

+(NSDictionary *)pulicParmas{
    return @{
        @"certainmesmerist": @"ios",
        @"writer":kAppVersion,
        @"forbusiness": kDeviceName,
        @"economist":@"idfv",
        @"sensefacts" : kDeviceSystemVersion,
        @"accustomed":@"secloanapi",
        @"accomplished":[LoginTools shared].getToken ?: @"",
        @"unusually":[ADTool shared].idfvString ?: @"",
        @"boyfine": [NSString randomString]
    };
}

@end

NS_ASSUME_NONNULL_END
