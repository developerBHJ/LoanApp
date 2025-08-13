//
//  TappedLabel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import "TappedLabel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TapLabelModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _linkTextColor = kBlackColor;
        _regularTextColor = kColor_6C6C6C;
        _linkTextFont = kFont(12);
        _regularTextFont = kFont(12);
    }
    return self;
}
@end

@implementation TappedLabel{
    UITapGestureRecognizer *_tapGesture;
}

- (instancetype)initWithFrame:(CGRect)frame model:(TapLabelModel *)model {
    self = [super initWithFrame:frame];
    if (self) {
        self.model = model;
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:_tapGesture];
        [self applyModel];
    }
    return self;
}

- (void)setModel:(TapLabelModel *)model {
    _model = model;
    [self applyModel];
}

- (void)applyModel {
    if (self.model.regluarText.length == 0) {
        return;
    }
    self.textColor = self.model.regularTextColor;
    self.font = self.model.regularTextFont;
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",
                                                                                           self.model.regluarText,
                                                                                           self.model.linkText]];
    [attStr addAttributes:@{
        NSForegroundColorAttributeName: self.model.linkTextColor,
        NSFontAttributeName: self.model.linkTextFont,
        NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)
    } range:NSMakeRange(attStr.length - self.model.linkText.length,
                        self.model.linkText.length)];
    
    self.attributedText = attStr;
}

- (void)handleTap:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self];
    CGSize labelSize = self.bounds.size;
    
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:labelSize];
    textContainer.lineFragmentPadding = 0.0;
    textContainer.lineBreakMode = self.lineBreakMode;
    textContainer.maximumNumberOfLines = self.numberOfLines;
    
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [layoutManager addTextContainer:textContainer];
    
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:self.attributedText];
    [textStorage addLayoutManager:layoutManager];
    
    NSUInteger index = [layoutManager characterIndexForPoint:point
                                             inTextContainer:textContainer
                    fractionOfDistanceBetweenInsertionPoints:nil];
    
    if (index < self.attributedText.length) {
        NSNumber *underlineValue = [self.attributedText attribute:NSUnderlineStyleAttributeName
                                                          atIndex:index
                                                   effectiveRange:nil];
        if (underlineValue != nil) {
            NSLog(@"点击了下划线部分");
            if (self.model.tapCompletion) {
                self.model.tapCompletion(self.model.linkUrl);
            }
        }
    }
}

@end

NS_ASSUME_NONNULL_END
