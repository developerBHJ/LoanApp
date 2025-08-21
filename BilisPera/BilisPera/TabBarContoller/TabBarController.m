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

@interface TabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) CustomTabBar *customTabBar;
@end

@implementation TabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self addChildViewController:[[HomeViewController alloc] init] title:@"Home" image:@"icon_home" selectedImage:@"icon_home_sel"];
    [self addChildViewController:[[OrderListViewController alloc] init] title:@"Order" image:@"icon_order" selectedImage:@"icon_order_sel"];
    [self addChildViewController:[[MineViewController alloc] init] title:@"Mine" image:@"icon_mine" selectedImage:@"icon_mine_sel"];
    [self setupCustomTabBar];
    self.delegate = self;
}

-(CustomTabBar *)customTabBar{
    if (!_customTabBar) {
        kWeakSelf;
        _customTabBar = [[CustomTabBar alloc] initWithFrame:CGRectZero completion:^(NSInteger index) {
            weakSelf.selectedIndex = index;
        }];
    }
    return _customTabBar;
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childController];
    //    nav.tabBarItem.title = title;
    //    nav.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    nav.tabBarItem.imageInsets = UIEdgeInsetsMake(-10, 0, 0, 0);
    //    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -15);
    [self addChildViewController:nav];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    self.customTabBar.defaultIndex = self.selectedIndex;
    [[PermissionTools shared] requestLocationAccessWithCompletion:^(BOOL success) {
    }];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    self.customTabBar.defaultIndex = self.selectedIndex;
}


- (void)setupCustomTabBar {
    self.tabBar.backgroundColor = [UIColor clearColor];
    self.tabBar.backgroundImage = nil;
    self.tabBar.shadowImage = nil;
    [self.tabBar addSubview:self.customTabBar];
    self.customTabBar.frame = CGRectMake(0, 0, kScreenW, kRatio(75) + kSafeAreaBottomHeight + kRatio(10));
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect rect = self.tabBar.frame;
    rect.size.height = kRatio(75) + kSafeAreaBottomHeight + kRatio(10);
    rect.origin.y = kScreenH - (kRatio(75) + kSafeAreaBottomHeight + kRatio(10));
    self.tabBar.frame = rect;
}

@end

NS_ASSUME_NONNULL_END
