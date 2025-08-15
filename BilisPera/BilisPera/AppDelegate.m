//
//  AppDelegate.m
//  BilisPera
//
//  Created by BHJ on 2025/8/5.
//

#import "AppDelegate.h"
#import "TabBarContoller/TabBarController.h"
#import "GuideViewController.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self changeRootViewController:![[LoginTools shared] isFirstLuanch]];
    [self configLanguage];
    [[TrackTools shared] configData];
    [[UITabBar appearance] setTranslucent:NO];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)changeRootViewController:(BOOL)needGuide{
    if (needGuide) {
        self.window.rootViewController = [[GuideViewController alloc] init];
    }else{
        if ([[LoginTools shared] getToken].length > 0) {
            self.window.rootViewController = [[TabBarController alloc] init];
        }else{
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
            self.window.rootViewController = nav;
        }
    }
}

-(void)configLanguage{
    [LocalizationManager setupWithModules:@{
        @"Home" : @"HomeMoudle",
        @"Common" : @"Localizable",
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.window endEditing:YES];
}

@end

