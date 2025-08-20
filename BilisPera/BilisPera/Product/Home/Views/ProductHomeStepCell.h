//
//  ProductHomeStepCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/16.
//

#import <Foundation/Foundation.h>
#import "ProductStepBannerItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductHomeStepCellModel : NSObject

@property (nonatomic, strong) NSArray<ProductStepBannerItemViewModel *> *stepArray;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *buttonTitle;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, assign) NSInteger progress;

@end

@interface ProductHomeStepCell : BaseTableViewCell

@end

NS_ASSUME_NONNULL_END
