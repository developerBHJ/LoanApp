//
//  BPSettingFooterView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/13.
//

#import "BPSettingFooterView.h"
#import "BPLayoutButton.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPSettingFooterView ()

@property (nonatomic, strong) BPLayoutButton *button;

@end


@implementation BPSettingFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(kRatio(40));
            make.centerX.equalTo(self);
            make.width.mas_equalTo(kRatio(170));
            make.height.mas_equalTo(kRatio(25));
        }];
    }
    return self;
}

- (BPLayoutButton *)button{
    if (!_button) {
        _button = [BPLayoutButton buttonWithType:UIButtonTypeCustom];
        _button.layoutStyle = BPLayoutButtonStyleLeftImageRightTitle;
        _button.midSpacing = kRatio(5);
        [_button setTitle:@"Account cancellation" forState:UIControlStateNormal];
        [_button setTitleColor:kColor_4E4E4E forState:UIControlStateNormal];
        _button.titleLabel.font = kFontMedium(14);
        [_button setImage:kGetImage(@"icon_logOff") forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(void)buttonEvent:(UIButton *)sender{
    if (self.completion) {
        self.completion();
    }
}

@end

NS_ASSUME_NONNULL_END
