//
//  LoginTools.h
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,JourneyLocale) {
    en = 0
};

@interface LoginTools : NSObject

+ (instancetype)shared;
-(void)showLoginView:(nullable void (^)(void) )completion;
-(NSString *)getToken;
-(NSString *)getUserName;
//  B面标识
-(NSString *)getCoffee;
//  登录链接字段,跳转B面用
-(NSString *)getCup;
-(BOOL )isFirstLuanch;
-(void)cleanUserData;

@end

NS_ASSUME_NONNULL_END
