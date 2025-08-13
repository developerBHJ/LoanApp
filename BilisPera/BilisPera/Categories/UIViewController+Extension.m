//
//  UIViewController+Extension.m
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

+ (UIViewController *)topMost {
    NSArray<UIWindow *> *currentWindows = [self getCurrentWindows];
    if (!currentWindows) {
        return nil;
    }
    UIViewController *rootViewController = [self getRootViewController:currentWindows];
    if (!rootViewController) {
        return nil;
    }
    return [self topMostOf:rootViewController];
}

+ (UIApplication *)sharedApplication {
    return [UIApplication sharedApplication];
}

+ (NSArray<UIWindow *> *)getCurrentWindows {
    return [[self sharedApplication] windows];
}

+ (UIViewController *)getRootViewController:(NSArray<UIWindow *> *)currentWindows {
    for (UIWindow *window in currentWindows) {
        if (window.isKeyWindow) {
            return window.rootViewController;
        }
    }
    return nil;
}
+ (UIViewController *)topMostOf:(UIViewController *)viewController {
    // presentedViewController
    if (viewController.presentedViewController) {
        return [self topMostOf:viewController.presentedViewController];
    }
    
    // tabBarController
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)viewController;
        if (tabBarController.selectedViewController) {
            return [self topMostOf:tabBarController.selectedViewController];
        }
    }
    
    // UINavigationController
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        if (navigationController.visibleViewController) {
            return [self topMostOf:navigationController.visibleViewController];
        }
    }
    
    // UIPageViewController
    if ([viewController isKindOfClass:[UIPageViewController class]]) {
        UIPageViewController *pageViewController = (UIPageViewController *)viewController;
        if (pageViewController.viewControllers.firstObject) {
            return [self topMostOf:pageViewController.viewControllers.firstObject];
        }
    }
    
    // childViewController
    for (UIView *subView in viewController.view.subviews) {
        if ([subView.nextResponder isKindOfClass:[UIViewController class]]) {
            return [self topMostOf:(UIViewController *)subView.nextResponder];
        }
    }
    return viewController;
}

+ (UINavigationController *)topMostNavigationControllerOf:(UIViewController *)viewController {
    // presentedViewController
    if (viewController.presentedViewController) {
        return [self topMostNavigationControllerOf:viewController.presentedViewController];
    }
    
    // tabBarController
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)viewController;
        if (tabBarController.selectedViewController) {
            return [self topMostNavigationControllerOf:tabBarController.selectedViewController];
        }
    }
    
    // UINavigationController
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        if (navigationController.visibleViewController) {
            return [self topMostNavigationControllerOf:navigationController.visibleViewController];
        }
    }
    return viewController.navigationController;
}

-(void)popNavigation:(BOOL)animated{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:animated completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:animated];
    }
}

-(void)presentFullScreen{
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self setModalInPresentation:YES];
}

-(void)showCustomAlertViewWith:(BPAlertViewModel *)model{
    BPAlertViewController *alertVC = [[BPAlertViewController alloc] initWith:model];
    [alertVC presentFullScreen];
    [self presentViewController:alertVC animated:NO completion:nil];
}

-(void)dismisCustomAlertView:(nullable simpleCompletion)completion{
    UIViewController *topVC = [UIViewController topMost];
    if ([topVC isKindOfClass:[BPAlertViewController class]]) {
        [topVC dismissViewControllerAnimated:false completion:completion];
    }
}

- (void)showCustomAlertWithTitle:(NSString *)title
                         message:(NSString *)message
               confirmCompletion:(simpleCompletion)confirmCompletion
                cancelCompletion:(simpleCompletion)cancelCompletion {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    // 设置警告框视图背景色和文字颜色
    alertController.view.backgroundColor = [UIColor whiteColor];
    // 设置消息文字颜色和字体
    if ([alertController.view.subviews.firstObject.subviews.firstObject isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)alertController.view.subviews.firstObject.subviews.firstObject;
        label.textColor = kBlackColor;
        label.font = kFont(14);
    }
    // 确认按钮
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"ok"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * _Nonnull action) {
        if (confirmCompletion) {
            confirmCompletion();
        }
    }];
    [confirmAction setValue:[UIColor blueColor] forKey:@"titleTextColor"];
    [alertController addAction:confirmAction];
    
    // 取消按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        if (cancelCompletion) {
            cancelCompletion();
        }
    }];
    [cancelAction setValue:[UIColor grayColor] forKey:@"titleTextColor"];
    [alertController addAction:cancelAction];
    // 显示警告框
    [self presentViewController:alertController animated:YES completion:nil];
}



@end
