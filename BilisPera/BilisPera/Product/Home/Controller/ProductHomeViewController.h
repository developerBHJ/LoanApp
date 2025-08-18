//
//  ProductHomeViewController.h
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import <Foundation/Foundation.h>
#import "ProductHomeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductHomeViewController : BaseViewController

- (instancetype)initWith:(NSString *)productId;
@property (nonatomic, strong) NSString *productId;

@end

NS_ASSUME_NONNULL_END
