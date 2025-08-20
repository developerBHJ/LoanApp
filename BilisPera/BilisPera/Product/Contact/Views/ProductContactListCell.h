//
//  ProductContactListCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import <Foundation/Foundation.h>
#import "ProdcutAuthenInputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductContactListCellModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) ProdcutAuthenInputViewModel *relationModel;
@property (nonatomic, strong) ProdcutAuthenInputViewModel *numberModel;
- (instancetype)initWithTitle:(NSString *)title relationModel:(ProdcutAuthenInputViewModel *)relationModel numberModel:(ProdcutAuthenInputViewModel *)numberModel;

@end

@interface ProductContactListCell : BaseTableViewCell

@end

NS_ASSUME_NONNULL_END
