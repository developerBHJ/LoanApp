//
//  APIService.h
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NetRequestType) {
    NetRequestType_POST = 0,
    NetRequestType_GET
};


typedef NS_ENUM(NSInteger,ServiceAPI) {
    GetVerfyCode = 0,
    LoginAndRegister = 1,
    GoogleMarket,
    UserLogOut,
    UserLogOff,
    HomePageData,
    Apply,
    ProductDetail,
    OrderList,
    OrderDetail,
    GetIdInfo,
    UploadImage,
    SaveUserInfo,
    GetPersonalInfo,
    GetUserAddress,
    SavePersonalInfo,
    GetUserWorkInfo,
    SaveUserWorkInfo,
    GetContactInfo,
    SaveContactInfo,
    GetBankInfo,
    SaveBankInfo,
    UploadLocation,
    UploadDeviceInfo,
    UploadContacts,
    APNPost,
    UploadRiskInfo,
};

typedef NS_ENUM(NSUInteger, BPRequestContentType) {
    BPRequestContentTypeFormURLEncoded,
    BPRequestContentTypeMultipartFormData,
    BPRequestContentTypeJSON
};

@interface APIService : NSObject

+(NSString *)getUrlWith:(ServiceAPI)service;
+(NetRequestType)getRequestType:(ServiceAPI)service;
+(NSDictionary *)pulicParmas;
+(BPRequestContentType)contentType:(ServiceAPI)service;

@end

NS_ASSUME_NONNULL_END
