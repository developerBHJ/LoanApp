//
//  UINavigationController+Extension.m
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import "UINavigationController+Extension.h"

@implementation UINavigationController (Extension)

- (void)popCurrentAndPushNewVC:(UIViewController *)newVC {
    NSMutableArray *viewControllers = [self.viewControllers mutableCopy];
    [viewControllers removeLastObject]; // 移除当前VC
    [viewControllers addObject:newVC];  // 添加新VC
    if (self.childViewControllers.count > 0) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, kRatio(44), kRatio(44));
        [backButton setImage:[kGetImage(@"icon_nav_back") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [backButton setImage:[kGetImage(@"icon_nav_back") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [backButton setImage:[kGetImage(@"icon_nav_back") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(popEvent) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton.imageView setUserInteractionEnabled:NO];
        newVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [newVC setHidesBottomBarWhenPushed:YES];
    }
    [self setViewControllers:viewControllers animated:YES];
}

-(void)popEvent{
    [self popViewControllerAnimated:YES];
}

@end
