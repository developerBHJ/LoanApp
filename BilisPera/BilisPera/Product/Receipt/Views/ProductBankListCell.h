//
//  ProductBankListCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import <Foundation/Foundation.h>
#import "ProdcutAuthenInputView.h"

NS_ASSUME_NONNULL_BEGIN
@interface ProductBankListCellModel : NSObject

@property (nonatomic, strong) NSArray<ProdcutAuthenInputViewModel *> *items;
- (instancetype)initWith:(NSArray<ProdcutAuthenInputViewModel *> *)items;

@end


@interface ProductBankListCell : BaseTableViewCell

@end

NS_ASSUME_NONNULL_END
