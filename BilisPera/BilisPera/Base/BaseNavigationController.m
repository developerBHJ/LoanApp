//
//  BaseNavigationController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/5.
//

#import "BaseNavigationController.h"

NS_ASSUME_NONNULL_BEGIN


@implementation BaseNavigationController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationBar setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: kBlackColor,NSFontAttributeName:kFont(18)}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, kRatio(44), kRatio(44));
        [backButton setImage:[kGetImage(@"icon_nav_back") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [backButton setImage:[kGetImage(@"icon_nav_back") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [backButton setImage:[kGetImage(@"icon_nav_back") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(popEvent) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton.imageView setUserInteractionEnabled:NO];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [super pushViewController:viewController animated:animated];
}


-(void)popEvent{
    [self popViewControllerAnimated:YES];
}



@end

NS_ASSUME_NONNULL_END
