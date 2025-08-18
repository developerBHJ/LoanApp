//
//  BPCircleProgressView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPCircleProgressView : UIView

@property (nonatomic, assign) NSInteger currentStep; // 当前步骤(1-5)
@property (nonatomic, strong) UIColor *activeColor;  // 激活节点颜色
@property (nonatomic, strong) UIColor *inactiveColor;// 非激活节点颜色
@property (nonatomic, strong) UIColor *activeTextColor;  // 激活节点颜色
@property (nonatomic, strong) UIColor *inactiveTextColor;// 非激活节点颜色
@property (nonatomic, strong) UIFont *textFont;// 非激活节点颜色
@property (nonatomic, strong) UIColor *lineColor;

@end

NS_ASSUME_NONNULL_END
