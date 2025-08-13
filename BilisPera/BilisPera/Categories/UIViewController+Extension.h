//
//  UIViewController+Extension.h
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import <UIKit/UIKit.h>
#import "BPAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extension)

+ (UIViewController *)topMost;
+ (UIApplication *)sharedApplication;
+ (NSArray<UIWindow *> *)getCurrentWindows;
+ (UIViewController *)getRootViewController:(NSArray<UIWindow *> *)currentWindows;
+ (UIViewController *)topMostOf:(UIViewController *)viewController;
+ (UINavigationController *)topMostNavigationControllerOf:(UIViewController *)viewController;

-(void)popNavigation:(BOOL)animated;
-(void)presentFullScreen;

-(void)showCustomAlertViewWith:(BPAlertViewModel *)model;
-(void)dismisCustomAlertView:(nullable simpleCompletion)completion;

- (void)showCustomAlertWithTitle:(NSString *)title
                         message:(NSString *)message
               confirmCompletion:(simpleCompletion)confirmCompletion
                cancelCompletion:(simpleCompletion)cancelCompletion;
@end

NS_ASSUME_NONNULL_END
