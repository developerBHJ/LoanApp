//
//  ProductBankListModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import "ProductBankListModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProductBankListFormModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"rage" : @"BPProductFormModel"};
}
@end

@implementation ProductBankListModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bolt" : @"ProductBankListFormModel"};
}
@end

NS_ASSUME_NONNULL_END
