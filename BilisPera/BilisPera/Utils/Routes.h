//
//  Routes.h
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPRoute : NSObject

// 设置页面
+(NSString *)settingPage;
// 首页
+(NSString *)homePage;
// 登录页
+(NSString *)loginView;
// 详情页
+(NSString *)productDetail;


@end

typedef void (^RouteHandler)(NSURL *url, NSDictionary<NSString *, NSString *> *params);
@interface Routes : NSObject

+ (instancetype)shared;
- (void)registerPattern:(NSString *)pattern handler:(RouteHandler)handler;
- (void)registerPattern:(NSString *)pattern host:(NSString *)host handler:(RouteHandler)handler;
- (BOOL)handleURL:(NSURL *)url;
- (void)routeTo:(NSString *)urlString;
- (void)registerRoutes;
- (void)handleRouter:(NSString *)route params:(NSDictionary *)params;
- (void)onPushWebView:(NSString *)url;
// 切换根视图
-(void)changeRootView;
// 跳转order页面
-(void)onPushOrderView:(BPOrderStatus)type;
// 到首页
-(void)backToHomeView;


@end

NS_ASSUME_NONNULL_END
