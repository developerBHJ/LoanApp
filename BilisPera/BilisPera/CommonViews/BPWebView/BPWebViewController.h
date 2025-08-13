//
//  BPWebViewController.h
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import <Foundation/Foundation.h>
#import "BPJSBridgeHandle.h"
#import "MessageUI/MessageUI.h"
#import "StoreKit/StoreKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPWebViewController : BaseViewController

@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) BOOL hiddenNavigationBar;


@end

NS_ASSUME_NONNULL_END
