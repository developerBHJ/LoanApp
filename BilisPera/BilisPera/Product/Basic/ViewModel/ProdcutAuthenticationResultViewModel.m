//
//  ProdcutAuthenticationResultViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import "ProdcutAuthenticationResultViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProdcutAuthenticationResultViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)reloadData:(NSString *)productId completion:(simpleCompletion)completion{
    kWeakSelf;
    [ProdcutAuthenticationTypeViewModel queryAuthAuthenticationDetail:productId completion:^(ProductAuthenticationIdInfo *model) {
        weakSelf.infoModel = model;
        completion();
    }];
}

@end

NS_ASSUME_NONNULL_END
