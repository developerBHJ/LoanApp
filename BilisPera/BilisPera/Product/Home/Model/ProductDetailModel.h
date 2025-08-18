//
//  ProductDetailModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailInfoModel : BaseModel
// 产品ID
@property (nonatomic, strong) NSString *rice;
// 产品名称
@property (nonatomic, strong) NSString *stew;
// 订单号
@property (nonatomic, strong) NSString *andto;
// 订单ID
@property (nonatomic, assign) NSInteger somner;
// 金额
@property (nonatomic, strong) NSString *officers;
// 描述文案
@property (nonatomic, strong) NSString *canvas;
// 期限
@property (nonatomic, strong) NSString *riflemenunder;
// 期限描述文案
@property (nonatomic, strong) NSString *troop;
// 利率
@property (nonatomic, strong) NSString *staunchfriend;
// 利率描述文案
@property (nonatomic, strong) NSString *wearrived;
//
@property (nonatomic, strong) NSString *complaintUrl;

@end

@interface ProductDetailStepModel : BaseModel
// 标题
@property (nonatomic, strong) NSString *enclosed;
// 副标题
@property (nonatomic, strong) NSString *compound;
//
@property (nonatomic, assign) NSInteger everyonehad;
// url
@property (nonatomic, strong) NSString *improbable;
// 是否已完成认证 0否1是
@property (nonatomic, assign) NSInteger building;
// 认证项类型,根据这个字段判断是哪一个认证项
@property (nonatomic, strong) NSString *trading;
//
@property (nonatomic, assign) NSInteger military;
//
@property (nonatomic, assign) NSInteger larder;
//
@property (nonatomic, assign) NSInteger jacob;
//
@property (nonatomic, strong) NSString *beef;
// 认证项log
@property (nonatomic, strong) NSString *grandsupply;

@end

@interface ProductDetailNextStepModel : BaseModel
// 判断此字段，如果为空的话 说明认证项已经全部认证成功，如果有值，就跳转到对应认证项里
@property (nonatomic, strong) NSString *trading;
//
@property (nonatomic, strong) NSString *improbable;
//
@property (nonatomic, assign) NSInteger everyonehad;
// 下一步的标题
@property (nonatomic, strong) NSString *enclosed;

@end

@interface ProductDetailModel : BaseModel
// 先判断这个字段，如果不等于200，取下面跳转链接字段拼上公参跳转，等于200正常显示数据
@property (nonatomic, assign) NSInteger thecavalry;
// 跳转链接
@property (nonatomic, strong) NSString *improbable;
// 产品信息
@property (nonatomic, strong) ProductDetailInfoModel *rhete;
// 认证项
@property (nonatomic, strong) NSArray<ProductDetailStepModel *> *palisade;
// 下一步
@property (nonatomic, strong) ProductDetailNextStepModel *packed;

@end

NS_ASSUME_NONNULL_END
