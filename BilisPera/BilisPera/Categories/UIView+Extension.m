//
//  UIView+Extension.m
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

-(void)addTapEvent:(nullable SEL)action{
    [self setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    [self addGestureRecognizer:tapGR];
}

-(void)configData:(id)data{
    
}

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:corners
                                                     cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = path.CGPath;
    self.layer.mask = mask;
}


@end
