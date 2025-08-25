//
//  LoginTools.m
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import "LoginTools.h"
#import "LoginViewController.h"
#import "BPADTools.h"

NS_ASSUME_NONNULL_BEGIN

@implementation LoginTools

+ (instancetype)shared {
    static LoginTools *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[LoginTools alloc] init];
    });
    return _shared;
}

-(void)showLoginView:(nullable void (^)(void) )completion{
    kUserDefaultRmove(tokenKey);
    [[Routes shared] changeRootView];
}

-(NSString *)getToken{
    return [[NSUserDefaults standardUserDefaults] valueForKey:tokenKey];
}

-(NSString *)getUserName{
    return [[NSUserDefaults standardUserDefaults] valueForKey:userNameKey];
}

-(NSString *)getCoffee{
    return [[NSUserDefaults standardUserDefaults] valueForKey:loginStatusKey];
}

- (NSString *)getCup{
    return [[NSUserDefaults standardUserDefaults] valueForKey:bPageKey];
}

-(BOOL )isFirstLuanch{
    return [[NSUserDefaults standardUserDefaults] boolForKey:isFirstLuanch];
}

-(void)cleanUserData{
    kUserDefaultRmove(tokenKey);
    kUserDefaultRmove(userNameKey);
    kUserDefaultRmove(loginStatusKey);
    kUserDefaultRmove(bPageKey);
    [BPADTools shared].trackCount = 0;
}

@end

NS_ASSUME_NONNULL_END
