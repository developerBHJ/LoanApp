//
//  UIStackView+Extension.m
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import "UIStackView+Extension.h"

@implementation UIStackView (Extension)

-(void)removeAllSubViews{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}

@end
