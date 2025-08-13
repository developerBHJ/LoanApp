//
//  BPProressHUD.h
//  BilisPera
//
//  Created by BHJ on 2025/8/8.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD/MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPProressHUD : NSObject
+ (void)showWindowesLoadingWithView:(UIView * _Nullable)view
                           message:(NSString * _Nullable)message
                         autoHide:(BOOL)autoHide
                           animated:(BOOL)animated ;
+ (void)showToastWithView:(UIView * _Nullable)view
                  message:(NSString * _Nullable)message;
+ (void)hideHUDQueryHUDWithView:(UIView * _Nullable)view ;

@end

NS_ASSUME_NONNULL_END
