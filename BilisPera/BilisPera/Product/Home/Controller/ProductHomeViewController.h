//
//  ProductHomeViewController.h
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import <Foundation/Foundation.h>
#import "ProductHomeViewModel.h"
#import "ProdcutBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductHomeViewController : ProdcutBaseViewController

- (instancetype)initWith:(NSString *)productId;

@end

NS_ASSUME_NONNULL_END
