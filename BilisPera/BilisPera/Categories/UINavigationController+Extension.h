//
//  UINavigationController+Extension.h
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (Extension)

- (void)popCurrentAndPushNewVC:(UIViewController *)newVC;

@end

NS_ASSUME_NONNULL_END
