//
//  TabBarController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/5.
//

#import "TabBarController.h"
#import "CustomTabBar.h"
#import "HomeViewController.h"
#import "OrderListViewController.h"
#import "MineViewController.h"
#import "BaseNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self configTabBar];
    [self addChildViewController:[[HomeViewController alloc] init] title:@"Home" image:@"icon_home" selectedImage:@"icon_home_sel"];
    [self addChildViewController:[[OrderListViewController alloc] init] title:@"Order" image:@"icon_order" selectedImage:@"icon_order_sel"];
    [self addChildViewController:[[MineViewController alloc] init] title:@"Mine" image:@"icon_mine" selectedImage:@"icon_mine_sel"];
}

-(void)configTabBar{
    [self setValue:[CustomTabBar new] forKey:@"tabBar"];
    [UITabBarItem.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColor.whiteColor,NSFontAttributeName: [UIFont systemFontOfSize:14 weight: UIFontWeightRegular]} forState:UIControlStateNormal];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childController];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.imageInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -15);
    [self addChildViewController:nav];
}

@end

NS_ASSUME_NONNULL_END
