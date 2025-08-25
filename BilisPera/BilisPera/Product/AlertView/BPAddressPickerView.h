//
//  BPAddressPickerView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import <Foundation/Foundation.h>
#import "BPAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPAddressPickerViewModel : NSObject

@property (nonatomic, assign) NSInteger contentHeight;
@property (nonatomic, strong) NSArray<BPAddressModel *> *dataSource;
@property (nonatomic, copy) simpleStringCompletion valueChanged;
@property (nonatomic, copy) simpleBoolCompletion completed;

@end

@interface BPAddressPickerView : UIView

@property (nonatomic, strong) BPAddressPickerViewModel *model;
- (instancetype)initWithFrame:(CGRect)frame model:(BPAddressPickerViewModel *)model;

- (void)nextStep;

@end

NS_ASSUME_NONNULL_END
