//
//  BPProductAuthInfoConfirmViewController.h
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import <Foundation/Foundation.h>
#import "BPProductAuthInfoConfirmViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPProductAuthInfoConfirmViewController : ProdcutBaseViewController

- (instancetype)initWith:(ProductAuthenIndetyInfoModel *)model productId:(NSString *)productId type:(NSString *)type completion:(simpleObjectCompletion)completion;

@end

NS_ASSUME_NONNULL_END
