//
//  BPProressHUD.m
//  BilisPera
//
//  Created by BHJ on 2025/8/8.
//

#import "BPProressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPProressHUD

+ (void)showWindowesLoadingWithView:(UIView * _Nullable)view
                            message:(NSString * _Nullable)message
                           autoHide:(BOOL)autoHide
                           animated:(BOOL)animated {
    dispatch_async(dispatch_get_main_queue(),
 ^{
        UIView *superView = view ?: UIApplication.sharedApplication.windows.firstObject;
        if (!superView) return;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:animated];
        hud.label.text = message ?: @"";
        hud.label.font = kFont(12);
        hud.margin = 10.0f;
        if (autoHide) {
            [hud hideAnimated:YES afterDelay:1.5];
        }
    });
}

+ (void)showToastWithView:(UIView * _Nullable)view
                  message:(NSString * _Nullable)message {
    if (message.length > 0) {
        dispatch_async(dispatch_get_main_queue(),^{
            UIView *superView = view ?: UIApplication.sharedApplication.windows.firstObject;
            if (!superView) return;
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = message ?: @"";
            hud.label.font = kFont(12);
            hud.margin = 10.0f;
            [hud hideAnimated:YES afterDelay:1.5];
        });
    }
}

+ (void)hideHUDQueryHUDWithView:(UIView * _Nullable)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *superView = view ?: UIApplication.sharedApplication.windows.firstObject;
        if (!superView) return;
        [MBProgressHUD hideHUDForView:superView animated:YES];
    });
}
@end

NS_ASSUME_NONNULL_END
