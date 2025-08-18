//
//  ProductHandle.h
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import <Foundation/Foundation.h>
#import "ProductDetailModel.h"

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
    BPProductFormStyleSelected,
};

typedef void(^productDetailList)(ProductDetailModel  * _Nullable model);

@interface ProductHandle : NSObject

+ (instancetype)shared;
// 申请
-(void)onPushDetailView:(NSString *)productId;
// 进认证首页
-(void)onPushDetailHomeView:(NSString *)productId;
// 进订单详情页
-(void)onPushOrderDetailView:(NSString *)productId completion:(simpleStringCompletion)completion;
// 获取认证流程
-(BPProductStep)getProductStepWith:(NSString *)step;
// 获取表单样式
-(BPProductFormStyle)getProductFormStyleWith:(NSString *)style;
// 查询认证列表数据
-(void)queryProductDetail:(NSString *)productId completion:(productDetailList)completion;
// 进行下一项认证
-(void)onPushNextStep:(NSString *)productId;
// 提交用户信息
-(void)saveUserInfoWithParamaters:(NSDictionary *)paramaters completion:(simpleBoolCompletion)completion;

@end

NS_ASSUME_NONNULL_END
