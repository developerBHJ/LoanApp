//
//  LoginViewModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) BOOL isAgress;

-(BOOL)checkCompletion;

-(void)getVerifyCodeWithCompletion:(nullable void(^)(BOOL))completion;
-(void)loginWithCompletion:(nullable void(^)(BOOL))completion;

@end

NS_ASSUME_NONNULL_END
