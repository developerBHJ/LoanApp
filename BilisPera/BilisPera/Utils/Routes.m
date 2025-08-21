//
//  Routes.m
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import "Routes.h"
#import "BPWebViewController.h"
#import "TabBarController.h"
#import "OrderListViewController.h"
#import "AppDelegate.h"
#import "BaseNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPRoute

// 设置页面
+(NSString *)settingPage{
    return @"/speltPikeYam";
}
// 首页
+(NSString *)homePage{
    return @"/paxpayaPinea";
}
// 登录页
+(NSString *)loginView{
    return @"/wasabiPepper";
}
// 详情页
+(NSString *)productDetail{
    return @"/watermelonPa";
}

@end

@interface Routes ()

@property (nonatomic,
           strong) NSMutableDictionary<NSString *, RouteHandler> *routes;

@end

@implementation Routes

+ (instancetype)shared {
    static Routes *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Routes alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _routes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registerPattern:(NSString *)pattern handler:(RouteHandler)handler {
    self.routes[pattern] = handler;
}

- (void)registerPattern:(NSString *)pattern host:(NSString *)host handler:(RouteHandler)handler {
    self.routes[pattern] = handler;
}

- (BOOL)handleURL:(NSURL *)url {
    NSURLComponents *components = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    if (!components) {
        return NO;
    }
    NSMutableDictionary<NSString *, NSString *> *params = [NSMutableDictionary dictionary];
    for (NSURLQueryItem *item in components.queryItems) {
        params[item.name] = item.value;
    }
    
    for (NSString *pattern in self.routes) {
        if ([self isMatchURL:url pattern:pattern]) {
            RouteHandler handler = self.routes[pattern];
            handler(url, params);
            return YES;
        }
    }
    return NO;
}

- (BOOL)isMatchURL:(NSURL *)url pattern:(NSString *)pattern {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSURLComponents *patternComponents = [NSURLComponents componentsWithString:pattern];
    if (!urlComponents || !patternComponents) {
        return NO;
    }
    return [urlComponents.scheme isEqualToString:patternComponents.scheme] &&
    [urlComponents.host isEqualToString:patternComponents.host];
}

- (void)routeTo:(NSString *)urlString {
    if (urlString.length == 0) {
        return;
    }
    if ([urlString hasPrefix:@"http"] || [urlString hasPrefix:@"https"]) {
        NSURL *url = [urlString getHtmlUrl];
        if (url) {
            [self handleURL:url];
        }
    } else {
        NSURL *url = [NSURL URLWithString:urlString];
        if (url) {
            [self handleURL:url];
        }
    }
}

- (void)registerRoutes {
    __weak typeof(self) weakSelf = self;
    [self registerPattern:kScheme handler:^(NSURL *url,
                                            NSDictionary<NSString *,
                                            NSString *> *params) {
        [weakSelf handleRouter:url.path params:params];
    }];
    
    [self registerPattern:kH5Host handler:^(NSURL *url,
                                            NSDictionary<NSString *,
                                            NSString *> *params) {
        [weakSelf onPushWebView:url.absoluteString];
    }];
    
    [self registerPattern:kH5Host1 handler:^(NSURL *url,
                                             NSDictionary<NSString *,
                                             NSString *> *params) {
        [weakSelf onPushWebView:url.absoluteString];
    }];
}

- (void)handleRouter:(NSString *)route params:(NSDictionary *)params {
    if ([route isEqual:BPRoute.homePage]) {
        UIViewController *topVC = [UIViewController topMost];
        for (UIViewController *vc in topVC.navigationController.viewControllers) {
            if ([vc isKindOfClass:[HomeViewController class]]) {
                [topVC.navigationController popToViewController:vc animated:YES];
                break;
            }
        }
        return;
    }else if ([route isEqual:BPRoute.loginView]){
        [[LoginTools shared] showLoginView:nil];
        return;
    }else if ([route isEqual:BPRoute.settingPage]){
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if (url) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
        return;
    }else if ([route isEqual:BPRoute.productDetail]){
        NSString *productId = [NSString stringWithFormat:@"%@",params[@"buy"]];
        [[ProductHandle shared] onPushProductHomeView:productId];
        return;
    }
}

- (void)onPushWebView:(NSString *)url {
    BPWebViewController *webView = [[BPWebViewController alloc] init];
    webView.url = [[url getHtmlUrl] absoluteString];
    [[UIViewController topMost].navigationController pushViewController:webView animated:YES];
}

-(void)changeRootView{
    AppDelegate *delegate =  (AppDelegate  *)[UIApplication sharedApplication].delegate;
    [delegate changeRootViewController:NO];
}

-(void)onPushOrderView:(BPOrderStatus)type{
    TabBarController *tabVC = (TabBarController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
    if (tabVC) {
        tabVC.selectedIndex = 1;
    }
    BaseNavigationController *nav = (BaseNavigationController *)tabVC.selectedViewController;
    OrderListViewController *orderVC = (OrderListViewController *)nav.childViewControllers.firstObject;
    orderVC.defaultStatus = type;
}

-(void)backToHomeView{
    TabBarController *tabVC = (TabBarController *)[UIApplication sharedApplication].windows.firstObject.rootViewController;
    if (tabVC) {
        tabVC.selectedIndex = 0;
    }
}

@end

NS_ASSUME_NONNULL_END
