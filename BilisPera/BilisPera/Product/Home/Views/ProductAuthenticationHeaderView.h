//
//  ProductAuthenticationHeaderView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import <Foundation/Foundation.h>
#import "ProductStepBannerItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductAuthenticationHeaderViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *imageName;
- (instancetype)initWith:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName;

@end

@interface ProductAuthenticationHeaderView : BaseTableViewCell


@end

NS_ASSUME_NONNULL_END
