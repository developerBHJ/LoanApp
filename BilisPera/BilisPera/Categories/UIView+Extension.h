//
//  UIView+Extension.h
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)

-(void)addTapEvent:(nullable SEL)action;

-(void)configData:(id)data;

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
