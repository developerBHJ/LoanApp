//
//  OrderListModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/15.
//

#import <Foundation/Foundation.h>
#import "OrderListCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderListInfoModel : BaseModel

// 订单ID
@property (nonatomic, assign) NSInteger somner;
// 产品ID
@property (nonatomic, assign) NSInteger myinexperience;
// log
@property (nonatomic, strong) NSString *hens;
// 产品名称
@property (nonatomic, strong) NSString *stew;
// 订单状态
@property (nonatomic, assign) NSInteger bulls;
// 订单状态文案
@property (nonatomic, strong) NSString *knolls;
// 金额描述
@property (nonatomic, strong) NSString *bluffs;
// 金额
@property (nonatomic, strong) NSString *outsiders;
// 日期文案
@property (nonatomic, strong) NSString *istheir;
// 日期
@property (nonatomic, strong) NSString *expedient;
// 期限文案
@property (nonatomic, strong) NSString *crawling;
// 期限
@property (nonatomic, strong) NSString *thehollows;
// 按钮文案
@property (nonatomic, strong) NSString *choosing;
// 订单描述
@property (nonatomic, strong) NSString *sky;
// 订单类型
@property (nonatomic, assign) OrderListType wepicketed;
// 跳转地址
@property (nonatomic, strong) NSString *nearest;

@end

@interface OrderListModel : BaseModel

// 订单ID
@property (nonatomic, assign) NSInteger somner;
// 订单ID
@property (nonatomic, strong) OrderListInfoModel *forwe;

@end

NS_ASSUME_NONNULL_END
