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
        case OrderDetail:
            url = @"/sudden/behind";
            break;
        case GetIdInfo:
            url = @"/sudden/paced";
            break;
        case UploadImage:
            url = @"/sudden/mostfavour";
            break;
        case SaveUserInfo:
            url = @"/sudden/stale";
            break;
        case GetPersonalInfo:
            url = @"/sudden/wecontrived";
            break;
        case GetUserAddress:
            url = @"/sudden/address";
            break;
        case SavePersonalInfo:
            url = @"/sudden/immortal";
            break;
        case GetUserWorkInfo:
            url = @"/sudden/conscienceevery";
            break;
        case SaveUserWorkInfo:
            url = @"/sudden/chusan";
            break;
        case GetContactInfo:
            url = @"/sudden/impose";
            break;
        case SaveContactInfo:
            url = @"/sudden/sitting";
            break;
        case GetBankInfo:
            url = @"/sudden/found";
            break;
        case SaveBankInfo:
            url = @"/sudden/estates";
            break;
        case UploadLocation:
            url = @"/sudden/librarianship";
            break;
        case UploadDeviceInfo:
            url = @"/sudden/patterns";
            break;
        case UploadContacts:
            url = @"/sudden/spencer";
            break;
        case APNPost:
            url = @"/sudden/officer";
            break;
        case UploadRiskInfo:
            url = @"/sudden/assistantour";
            break;
    }
    return [NSString stringWithFormat:@"%@%@%@%@%@",kBaseUrl,@"/genius",url,@"?",[APIService pulicParmas].toURLStrings];
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
        case GetIdInfo:
            type = NetRequestType_GET;
            break;
        case GetUserAddress:
            type = NetRequestType_GET;
            break;
        case GetBankInfo:
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
        case UploadImage:
            type = BPRequestContentTypeMultipartFormData;
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
        @"unusually": [[BPADTools shared] getIDFV] ?: @"",
        @"boyfine": [NSString randomString]
    };
}

+(BOOL)showMesage:(ServiceAPI)service{
    BOOL showMessage = NO;
    switch (service) {
        case GetVerfyCode:
            showMessage = YES;
            break;
        default:
            showMessage = NO;
    }
    return showMessage;
}

@end

NS_ASSUME_NONNULL_END
