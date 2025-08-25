//
//  LoginViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import "LoginViewModel.h"
#import "BPWifiInfoHandle.h"

NS_ASSUME_NONNULL_BEGIN

@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isAgress = YES;
    }
    return self;
}

-(BOOL)checkCompletion{
    BOOL isCompleted = NO;
    if (_phoneNum.length > 0 && _code.length > 0 &&  _isAgress) {
        isCompleted = YES;
    }
    return isCompleted;
}

-(void)getVerifyCodeWithCompletion:(nullable void(^)(BOOL))completion{
    if (self.phoneNum.length > 0) {
        [[HttpManager shared] requestWithService:GetVerfyCode parameters:@{@"theglutton":self.phoneNum,@"eachshould":[NSString randomString]} showLoading:true showMessage:true bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
            completion(YES);
        } failure:^(NSError * _Nonnull error,
                    NSDictionary * _Nonnull errorDictionary) {
            completion(NO);
        }];
    }
}

-(void)loginWithCompletion:(nullable void(^)(BOOL))completion{
    if (self.phoneNum.length == 0 || self.code.length == 0) {
        return;
    }
    NSMutableDictionary *paramas = [[NSMutableDictionary alloc] init];
    paramas[@"decency"] = self.phoneNum;
    paramas[@"allhe"] = self.code;
    paramas[@"offilthy"] = [NSString randomString];
    paramas[@"eating"] = [BPWifiInfoHandle isVPNConnected] ? @"1" : @"0";
    paramas[@"disgusting"] = [BPWifiInfoHandle isProxyEnabled] ? @"1" : @"0";
    paramas[@"greediness"] = @"en";
    kWeakSelf;
    [[HttpManager shared] requestWithService:LoginAndRegister parameters:paramas showLoading:YES showMessage:YES bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        [weakSelf handleData: response.couldsee];
        completion(YES);
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion(NO);
    }];
}

-(void)handleData:(id)data{
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)data;
        NSString *phoneNum = [NSString stringWithFormat:@"%@",dic[@"decency"]];
        // sessionId
        NSString *sessionId = [NSString stringWithFormat:@"%@",
                               dic[@"accomplished"]];
        // B面标识
        NSString *coffee = [NSString stringWithFormat:@"%@",dic[@"coffee"]];
        // 登录链接字段,跳转B面用
        NSString *cup = [NSString stringWithFormat:@"%@",dic[@"cup"]];
        kUserDefaultSet(phoneNum, userNameKey);
        kUserDefaultSet(sessionId, tokenKey);
        kUserDefaultSet(coffee, loginStatusKey);
        kUserDefaultSet(cup, bPageKey);
    }
}

@end

NS_ASSUME_NONNULL_END
