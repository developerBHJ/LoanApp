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
        case UserLogOut:
            url = @"/sudden/chance";
            break;
        case UserLogOff:
            url = @"/sudden/chance";
            break;
        case HomePageData:
            url = @"/sudden/agreedto";
            break;
        case Apply:
            url = @"/sudden/oneday";
            break;
        case ProductDetail:
            url = @"/sudden/emptystomachone";
            break;
        case OrderList:
            url = @"/sudden/three";
            break;
    }
    return [NSString stringWithFormat:@"%@%@?%@",kBaseUrl,url,[APIService pulicParmas].toURLStrings];
}

+(NetRequestType)getRequestType:(ServiceAPI)service{
    NetRequestType type = NetRequestType_POST;
    switch (service) {
        case UserLogOff:
            type = NetRequestType_GET;
            break;
        case UserLogOut:
            type = NetRequestType_GET;
            break;
        case HomePageData:
            type = NetRequestType_GET;
            break;
        default:
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
