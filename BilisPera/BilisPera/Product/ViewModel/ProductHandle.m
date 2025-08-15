//
//  ProductHandle.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "ProductHandle.h"
#import "ProductHomeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProductHandle
+ (instancetype)shared {
    static ProductHandle *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[ProductHandle alloc] init];
    });
    return _shared;
}

-(void)onPushDetailView:(NSString *)productId{
    ProductHomeViewController *homeVC = [[ProductHomeViewController alloc] initWith:productId];
    [[UIViewController topMost].navigationController pushViewController:homeVC animated:YES];
}

@end

NS_ASSUME_NONNULL_END
