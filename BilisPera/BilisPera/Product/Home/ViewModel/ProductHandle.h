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
-(void)enterNextStepViewWith:(NSString *)productId step:(BPProductStep)step title:(NSString *)title type:(NSString *)type;
// 进行下一项认证
-(void)onPushNextStep:(NSString *)productId type:(NSString *)type;
// 提交用户信息
-(void)saveUserInfoWithParamaters:(NSDictionary *)paramaters completion:(simpleBoolCompletion)completion;
// 获取地址列表
-(void)requestAddressList;

@end

NS_ASSUME_NONNULL_END
