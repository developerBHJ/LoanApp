//
//  HttpManager.h
//  BilisPera
//
//  Created by BHJ on 2025/8/8.
//

#import <Foundation/Foundation.h>
#import "HttpResponse.h"
#import "AFNetwork/AFNetwork.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^requestSuccessBlock)(HttpResponse *response);
typedef void(^requestFailureBlock)(NSError *error,NSDictionary *errorDictionary);

@interface HttpManager : NSObject

+ (instancetype)shared;

- (void)requestWithService:(ServiceAPI)service
            parameters:(NSDictionary *)params
            showLoading:(BOOL)showLoading
            showMessage:(BOOL)showMessage
            bodyBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))block
              success:(requestSuccessBlock)success
              failure:(requestFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
