//
//  HomeViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/5.
//

#import "HomeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation HomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [[Routes shared] registerRoutes];
    
}

@end

NS_ASSUME_NONNULL_END
