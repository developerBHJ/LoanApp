//
//  HttpManager.m
//  BilisPera
//
//  Created by BHJ on 2025/8/8.
//

#import "HttpManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HttpManager ()

@end

@implementation HttpManager

+ (instancetype)shared {
    static HttpManager *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
        _shared = [[self alloc] init];
    });
    return _shared;
}

- (void)requestWithService:(ServiceAPI)service
                parameters:(NSDictionary *)params
               showLoading:(BOOL)showLoading
               showMessage:(BOOL)showMessage
                 bodyBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))bodyBlock
                   success:(requestSuccessBlock)success
                   failure:(requestFailureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30;
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/json",
                                                         @"text/javascript",
                                                         @"text/html",
                                                         @"text/plain",
                                                         nil];
    BPRequestContentType contentType = [APIService contentType:service];
    // 根据类型设置请求头
    switch (contentType) {
        case BPRequestContentTypeFormURLEncoded:
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            break;
        case BPRequestContentTypeMultipartFormData:
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case BPRequestContentTypeJSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            break;
    }
    NetRequestType method = [APIService getRequestType:service];
    NSString *urlString = [APIService getUrlWith:service];
    if (showLoading) {
        [BPProressHUD showWindowesLoadingWithView:nil message:@"" autoHide:NO animated:YES];
    }
    kWeakSelf;
    // 处理不同请求方法
    if (method == NetRequestType_GET) {
        [manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task,
                                                                        id  _Nullable responseObject) {
            [weakSelf handleSuccess:responseObject success:success showMessage:showMessage];
        } failure:^(NSURLSessionDataTask * _Nullable task,
                    NSError * _Nonnull error) {
            [weakSelf handleFailure:error failure:failure];
        }];
    } else if (method == NetRequestType_POST) {
        if (contentType == BPRequestContentTypeMultipartFormData) {
            [manager POST:urlString parameters:params constructingBodyWithBlock:bodyBlock progress:nil success:^(NSURLSessionDataTask * _Nonnull task,
                                                                                                                 id  _Nullable responseObject) {
                [weakSelf handleSuccess:responseObject success:success showMessage:showMessage];
            } failure:^(NSURLSessionDataTask * _Nullable task,
                        NSError * _Nonnull error) {
                [weakSelf handleFailure:error failure:failure];
            }];
        } else {
            [manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task,
                                                                             id  _Nullable responseObject) {
                [weakSelf handleSuccess:responseObject success:success showMessage:showMessage];
            } failure:^(NSURLSessionDataTask * _Nullable task,
                        NSError * _Nonnull error) {
                [weakSelf handleFailure:error failure:failure];
            }];
        }
    }
}

-(void)handleSuccess:(id  _Nullable)responseObject success:(requestSuccessBlock)success showMessage:(BOOL)showMessage{
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
    HttpResponse *model = [HttpResponse mj_objectWithKeyValues:data];
    [BPProressHUD hideHUDQueryHUDWithView:nil];
    if (showMessage) {
        [BPProressHUD showToastWithView:nil message:model.forbreakfast];
    }
    NSLog(@"%@",model.couldsee);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (model.resolution == 0) {
            success(model);
        }else if(model.resolution == -2){
            [[LoginTools shared] showLoginView:nil];
        }
    });
}

-(void)handleFailure:(NSError * _Nonnull)error failure:(requestFailureBlock)failure{
    NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        failure(error,dic);
    });
    [BPProressHUD hideHUDQueryHUDWithView:nil];
}

@end




NS_ASSUME_NONNULL_END
