//
//  ProdcutIdFaceIDViewController.h
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import <Foundation/Foundation.h>
#import "ProdcutBaseViewController.h"
#import "ProdcutIdFaceIDViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutIdFaceIDViewController : ProdcutBaseViewController

- (instancetype)initWith:(NSString *)productId title:(NSString *)title type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
