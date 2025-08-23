//
//  ProductHandle.h
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import <Foundation/Foundation.h>
#import "ProductDetailModel.h"
#import "BPAddressModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,BPProductStep) {
    BPProductStepFaceId =1,
    BPProductStepBasic,
    BPProductStepWork,
    BPProductStepContact,
    BPProductStepBank,
};

typedef NS_ENUM(NSInteger,BPProductFormStyle) {
    BPProductFormStyleEnum =1,
    BPProductFormStyleText,
    BPProductFormStyleCitySelected,
};

typedef void(^productDetailList)(ProductDetailModel  * _Nullable model);

@interface ProductHandle : NSObject

+ (instancetype)shared;

@property (nonatomic, strong) NSArray<BPAddressModel *> *addressList;
// 是否需要强制定位
@property (nonatomic, assign) BOOL needLocation;

// 获取认证流程
-(BPProductStep)getProductStepWith:(NSString *)step;
// 获取表单样式
-(BPProductFormStyle)getProductFormStyleWith:(NSString *)style;
// 查询认证列表数据
-(void)queryProductDetail:(NSString *)productId completion:(productDetailList)completion;
// 提交用户信息
-(void)saveUserInfoWithParamaters:(NSDictionary *)paramaters completion:(simpleBoolCompletion)completion;

// 获取地址列表
-(void)requestAddressList;

-(void)apply:(NSString *)productId;
// 进入产品首页
-(void)onPushProductHomeView:(NSString *)productId;
// 进入认证页面
-(void)enterAuthenView:(NSString *)productId type:(NSString *)type;
// 进入具体某个认证页面
-(void)enterNextStepViewWith:(NSString *)productId step:(BPProductStep)step title:(NSString *)title type:(NSString *)type;
// 检查是否都已认证完成
-(void)checkAuthCompleted:(simpleBoolCompletion)completion;

@end

NS_ASSUME_NONNULL_END
