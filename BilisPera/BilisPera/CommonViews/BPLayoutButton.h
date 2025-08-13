//
//  BPLayoutButton.h
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BPLayoutButtonStyle) {
    BPLayoutButtonStyleLeftImageRightTitle,
    BPLayoutButtonStyleLeftTitleRightImage,
    BPLayoutButtonStyleUpImageDownTitle,
    BPLayoutButtonStyleUpTitleDownImage
};

@interface BPLayoutButton : UIButton

/// 布局方式
@property (nonatomic, assign) BPLayoutButtonStyle layoutStyle;
/// 图片和文字的间距，默认值8
@property (nonatomic, assign) CGFloat midSpacing;
/// 指定图片size
@property (nonatomic, assign) CGSize imageSize;
@end

NS_ASSUME_NONNULL_END
