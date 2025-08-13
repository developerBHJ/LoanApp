//
//  BPJSBridgeHandle.m
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import "BPJSBridgeHandle.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPJSMethod
// 风控埋点
+(NSString *)uploadRiskLoan{
    return @"squaxshRa";
}
// 跳转原生或者H5
+(NSString *)openUrl{
    return @"tangerine";
}
// 关闭当前H5
+(NSString *)closeSyn{
    return @"jideHoney";
}
// 跳转首页
+(NSString *)jumpToHome{
    return @"vultureKa";
}
// 发邮件
+(NSString *)callPhoneMethod{
    return @"avocadoYa";
}
// 拉起系统评分
+(NSString *)toGrade{
    return @"eggxplant";
}

@end

@interface BPJSBridgeHandle ()<WKScriptMessageHandler>

@end

@implementation BPJSBridgeHandle

- (instancetype)initWithWebView:(WKWebView *)webView {
    self = [super init];
    if (self) {
        _webView = webView;
        _messageHandlers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc {
    [self.webView.configuration.userContentController removeAllScriptMessageHandlers];
}

- (void)registerHandler:(NSString *)name handler:(void (^)(id))handler {
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:name];
    self.messageHandlers[name] = handler;
}

- (void)callJS:(NSString *)method params:(NSDictionary *)params completion:(void (^)(id, NSError *))completion {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] ?: @"{}";
    NSString *js = [NSString stringWithFormat:@"window.%@(%@)",
                    method,
                    jsonString];
    
    dispatch_async(dispatch_get_main_queue(),
                   ^{
        [self.webView evaluateJavaScript:js completionHandler:^(id result,
                                                                NSError *error) {
            if (completion) {
                completion(result, error);
            }
        }];
    });
}

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    void (^handler)(id) = self.messageHandlers[message.name];
    if (handler) {
        handler(message.body);
    }
}


@end

NS_ASSUME_NONNULL_END
