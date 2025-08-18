//
//  BPProductAuthInfoConfirmViewController.h
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import <Foundation/Foundation.h>
#import "BPProductAuthInfoConfirmViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPProductAuthInfoConfirmViewController : BaseViewController

- (instancetype)initWith:(ProductAuthenIndetyInfoModel *)model productId:(NSString *)productId;

@end

NS_ASSUME_NONNULL_END
