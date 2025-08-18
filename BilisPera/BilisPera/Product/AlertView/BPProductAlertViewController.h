//
//  BPProductAlertViewController.h
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import <Foundation/Foundation.h>
#import "BPAlertHeasderView.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPProductAlertViewControllerModel : NSObject

@property (nonatomic, strong) BPAlertHeasderViewModel *headerModel;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) BOOL needConfirm;
@property (nonatomic, copy) simpleCompletion confirmCompletion;

@end

@interface BPProductAlertViewController : UIViewController

- (instancetype)initWith:(BPProductAlertViewControllerModel *)model;
@property (nonatomic, strong) BPProductAlertViewControllerModel *model;

@end

NS_ASSUME_NONNULL_END
