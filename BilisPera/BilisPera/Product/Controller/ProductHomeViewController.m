//
//  ProductHomeViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "ProductHomeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProductHomeViewController

- (instancetype)initWith:(NSString *)productId
{
    self = [super init];
    if (self) {
        self.productId = productId;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
