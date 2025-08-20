//
//  BPCircleProgressView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/16.
//

#import "BPCircleProgressView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPCircleProgressView ()

@end

@implementation BPCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _currentStep = 0;
        _activeColor = kWhiteColor;
        _inactiveColor = kColor_FDE7F1;
        _activeTextColor = kBlackColor;
        _inactiveTextColor = kColor_BEBEBE;
        _lineColor = kBlackColor;
        _textFont = kFont(16);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat nodeDiameter = kRatio(24);
    CGFloat lineWidth = 2.0;
    // 计算节点中心点
    CGFloat spacing = (width - 5*nodeDiameter) / 4;
    CGPoint centers[5];
    for (int i = 0; i < 5; i++) {
        centers[i] = CGPointMake(nodeDiameter/2 + i*(nodeDiameter + spacing),
                                 height/2);
    }
    // 绘制连接线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    CGContextSetLineWidth(context, lineWidth);
    CGFloat dashPattern[] = {3, 2};
    CGContextSetLineDash(context, 0, dashPattern, 2);
    
    for (int i = 0; i < 4; i++) {
        CGContextMoveToPoint(context,
                             centers[i].x + nodeDiameter/2,
                             centers[i].y);
        CGContextAddLineToPoint(context,
                                centers[i+1].x - nodeDiameter/2,
                                centers[i+1].y);
        CGContextStrokePath(context);
    }
    
    // 绘制节点
    for (int i = 0; i < 5; i++) {
        UIColor *fillColor = (i < _currentStep) ? _activeColor : _inactiveColor;
        UIColor *textColor = (i < _currentStep) ? _activeTextColor : _inactiveTextColor;
        if (_currentStep == 0) {
            fillColor = _inactiveColor;
            textColor = _inactiveTextColor;
        }
        // 绘制外圆
        CGRect circleRect = CGRectMake(centers[i].x - nodeDiameter/2,
                                       centers[i].y - nodeDiameter/2,
                                       nodeDiameter, nodeDiameter);
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        CGContextFillEllipseInRect(context, circleRect);
        
        // 绘制数字
        NSString *text = [NSString stringWithFormat:@"%d", i+1];
        NSDictionary *attrs = @{
            NSFontAttributeName: self.textFont,
            NSForegroundColorAttributeName: textColor
        };
        CGSize textSize = [text sizeWithAttributes:attrs];
        CGPoint textOrigin = CGPointMake(centers[i].x - textSize.width/2,
                                         centers[i].y - textSize.height/2);
        [text drawAtPoint:textOrigin withAttributes:attrs];
    }
}

- (void)setCurrentStep:(NSInteger)currentStep {
    _currentStep = MAX(0, MIN(5, currentStep));
    [self setNeedsDisplay];
}

- (void)setActiveColor:(UIColor *)activeColor{
    _activeColor = activeColor;
    [self setNeedsDisplay];
}

- (void)setInactiveColor:(UIColor *)inactiveColor{
    _inactiveColor = inactiveColor;
    [self setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)setActiveTextColor:(UIColor *)activeTextColor{
    _activeTextColor = activeTextColor;
    [self setNeedsDisplay];
}

- (void)setInactiveTextColor:(UIColor *)inactiveTextColor{
    _inactiveTextColor = inactiveTextColor;
    [self setNeedsDisplay];
}

- (void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    [self setNeedsDisplay];
}

@end

NS_ASSUME_NONNULL_END
