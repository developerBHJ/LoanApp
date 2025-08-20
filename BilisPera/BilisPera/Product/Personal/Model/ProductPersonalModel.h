//
//  ProductPersonalModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPProductFormModel : BaseModel
// 单选框的值,用于显示和回显
@property (nonatomic, strong) NSString *tongues;
// 单选框的key，string类型
@property (nonatomic, strong) NSString *everyonehad;

// 图标
@property (nonatomic, strong) NSString *consulted;


@end

@interface BPProductFormEditModel : BaseModel
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;
// 单选框的key，用于保存时传参
@property (nonatomic, strong) NSString *general;

- (instancetype)initWith:(NSString *)key value:(NSString *)value general:(NSString *)general;

@end


@interface ProductPersonalModel : BaseModel
// productID
@property (nonatomic, strong) NSString *rice;
// 标题
@property (nonatomic, strong) NSString *enclosed;
// 标题描述
@property (nonatomic, strong) NSString *compound;
// 唯一标识  ~~~~~~保存时作为传参的key~~~~~~
@property (nonatomic, strong) NSString *resolution;
//  输入框类型 （单选框，输入框，地区选择框）
@property (nonatomic, strong) NSString *hiding;
//  键盘类型，输入框需要用到（0 为全键盘，1 为数字键盘）
@property (nonatomic, assign) NSInteger toour;
//  单选框的选项数组
@property (nonatomic, strong) NSArray<BPProductFormModel *> *rage;
//  value 回显用
@property (nonatomic, strong) NSString *savethe;
//   key   ~~~~~~保存时作为传参的value~~~~~~
@property (nonatomic, strong) NSString *everyonehad;

// 日期选择器
@property (nonatomic, strong) NSString *skelter;

@end

NS_ASSUME_NONNULL_END
