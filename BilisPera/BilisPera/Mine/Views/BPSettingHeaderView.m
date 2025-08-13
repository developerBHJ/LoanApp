//
//  BPSettingHeaderView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import "BPSettingHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPSettingHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation BPSettingHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).inset(kRatio(16));
        make.top.equalTo(self).inset(kRatio(20));
        make.trailing.equalTo(self).inset(kRatio(16));
    }];
    
    [self addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).inset(kRatio(16));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(13));
        make.trailing.equalTo(self).inset(kRatio(16));
        make.bottom.equalTo(self);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kColor_B43E64;
        _titleLabel.font = kFont(20);
        _titleLabel.text = @"Safe and secure";
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = kBlackColor;
        _subTitleLabel.font = kFont(14);
        _subTitleLabel.numberOfLines = 0;
        _subTitleLabel.text = @"Protect your security and privacy throughout the process";
    }
    return _subTitleLabel;
}

@end

NS_ASSUME_NONNULL_END
