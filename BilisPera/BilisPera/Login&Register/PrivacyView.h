//
//  PrivacyView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import <Foundation/Foundation.h>
#import "TappedLabel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^checkBoxCompletion)(BOOL);

@interface PrivacyViewModel : NSObject

@property (nonatomic, strong) TapLabelModel *tapModel;
@property (nonatomic, assign) BOOL isAlert;
@property (nonatomic, assign) BOOL isAgree;
@property (nonatomic, copy,nullable) checkBoxCompletion checkBoxCompletion;

@end

@interface PrivacyView : UIView

@property (nonatomic, strong,nullable) PrivacyViewModel *model;
- (instancetype)initWithFrame:(CGRect)frame model:(nonnull PrivacyViewModel *)model;

@end

NS_ASSUME_NONNULL_END
