//
//  ProdcutAuthenticationTypeCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import <Foundation/Foundation.h>
#import "ProdcutAuthenticationItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutAuthenticationTypeCellModel : NSObject

@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, strong) NSArray<ProdcutAuthenticationItemViewModel *> *items;
- (instancetype)initWith:(NSString *)title items:(NSArray *)items;

@end


@interface ProdcutAuthenticationTypeCell : BaseTableViewCell

@end

NS_ASSUME_NONNULL_END
