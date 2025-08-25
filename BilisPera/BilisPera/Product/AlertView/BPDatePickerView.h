//
//  BPDatePickerView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPDatePickerViewModel : NSObject

@property (nonatomic, assign) NSInteger contentHeight;
@property (nonatomic, strong) NSString *currentDate;
@property (nonatomic, copy) simpleStringCompletion valueChanged;

@end

@interface BPDatePickerView : UIView

@property (nonatomic, strong) BPDatePickerViewModel *model;
- (instancetype)initWithFrame:(CGRect)frame model:(BPDatePickerViewModel *)model;

@end

NS_ASSUME_NONNULL_END
