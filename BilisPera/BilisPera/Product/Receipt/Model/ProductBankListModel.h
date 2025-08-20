//
//  ProductBankListModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductBankListFormModel : BaseModel

// 标题
@property (nonatomic, strong) NSString *enclosed;
//
@property (nonatomic, strong) NSString *resolution;
//
@property (nonatomic, strong) NSString *compound;
//
@property (nonatomic, strong) NSString *hiding;
//
@property (nonatomic, strong) NSArray<BPProductFormModel *> *rage;
// 下拉的value值    最终展示字段
@property (nonatomic, strong) NSString *savethe;
// 下拉的key值       最终传参字段
@property (nonatomic, strong) NSString *everyonehad;

@end

@interface ProductBankListModel : BaseModel
// 类型：电子钱包
@property (nonatomic, strong) NSString *enclosed;
// 类型标识： 1 电子钱包 2银行卡
@property (nonatomic, assign) NSInteger everyonehad;
// items 里面也是动态表单-参考用户信息或者工作信息一致
@property (nonatomic, strong) NSArray<ProductBankListFormModel *> *bolt;


@end

NS_ASSUME_NONNULL_END
