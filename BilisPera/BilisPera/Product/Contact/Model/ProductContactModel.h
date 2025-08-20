//
//  ProductContactModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import <Foundation/Foundation.h>
#import "ProductPersonalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductContactModel : NSObject
// 当前 item 的标题 （用于显示）
@property (nonatomic, strong) NSString *alarm;
// 当前 item 选中的关系 key（回显的时候会用到）
@property (nonatomic, strong) NSString *tribe;
// - 当前 item 联系人的电话（用于回显）
@property (nonatomic, strong) NSString *patriarch;
//  当前 item 联系人的姓名（用于回显）
@property (nonatomic, strong) NSString *tongues;
//   当前 item 的标识 number（用于保存数据)
@property (nonatomic, strong) NSString *prairiedogs;
//   选择关系的title（图片或文案）（用于显示）
@property (nonatomic, strong) NSString *quietlytrotted;
//  选择关系的提示 （用于显示）
@property (nonatomic, strong) NSString *suspiciously;
//  选择号码的title（图片或文案）（用于显示）
@property (nonatomic, strong) NSString *wolves;
//  选择号码的提示（用于显示）
@property (nonatomic, strong) NSString *forrattlesnakes;
//  关系选项的列表
@property (nonatomic, strong) NSArray<BPProductFormModel *>  *sand;

@end

NS_ASSUME_NONNULL_END
