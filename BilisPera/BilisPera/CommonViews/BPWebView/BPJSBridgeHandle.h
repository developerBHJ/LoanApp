//
//  BPJSBridgeHandle.h
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import <Foundation/Foundation.h>
#import "WebKit/WebKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPJSMethod : NSObject
// 风控埋点
+(NSString *)uploadRiskLoan;
// 跳转原生或者H5
+(NSString *)openUrl;
// 关闭当前H5
+(NSString *)closeSyn;
// 跳转首页
+(NSString *)jumpToHome;
// 发邮件
+(NSString *)callPhoneMethod;
// 拉起系统评分
+(NSString *)toGrade;
@end

@interface BPJSBridgeHandle : NSObject

@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, strong) NSMutableDictionary<NSString *, void (^)(id)> *messageHandlers;

- (instancetype)initWithWebView:(WKWebView *)webView;
- (void)registerHandler:(NSString *)name handler:(void (^)(id))handler;
- (void)callJS:(NSString *)method params:(NSDictionary *)params completion:(void (^)(id, NSError *))completion;

@end

NS_ASSUME_NONNULL_END
