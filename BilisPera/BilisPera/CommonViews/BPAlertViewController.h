//
//  BPAlertViewController.h
//  BilisPera
//
//  Created by BHJ on 2025/8/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,BPAlertViewType) {
    BPAlertViewTypeStay = 0,
    BPAlertViewTypeExit,
    BPAlertViewTypeCancellation,
    BPAlertViewTypeReloan,
};

@interface BPAlertViewModel : NSObject

- (instancetype)initWith:(BPAlertViewType)type;

@property (nonatomic, assign) BPAlertViewType type;
@property (nonatomic, copy,nullable) simpleCompletion confirmCompletion;
@property (nonatomic, copy,nullable) simpleCompletion cancelCompletion;
@property (nonatomic, copy,nullable) simpleBoolCompletion selectedCompletion;

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *content;
@property (nonatomic, strong, readonly) NSString *confirmBtnTitle;
@property (nonatomic, strong, readonly) NSString *cancelBtnTitle;

@end


@interface BPAlertViewController : BaseViewController

@property (nonatomic, strong) BPAlertViewModel *model;
- (instancetype)initWith:(BPAlertViewModel *)model;

@end

NS_ASSUME_NONNULL_END
