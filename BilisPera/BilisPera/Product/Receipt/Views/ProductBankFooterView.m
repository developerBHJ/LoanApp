//
//  ProductBankFooterView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/21.
//

#import "ProductBankFooterView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductBankFooterView ()

@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *contentLabel;


@end

@implementation ProductBankFooterView

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
    [self addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).inset(kRatio(19));
        make.top.bottom.equalTo(self).inset(kRatio(16));
        make.trailing.equalTo(self).inset(kRatio(30));
    }];
    
    [self addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentBgView);
        make.leading.equalTo(self).inset(kRatio(30));
        make.width.height.mas_equalTo(kRatio(51));
    }];
    
    [self.contentBgView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentBgView).inset(kRatio(5));
        make.leading.equalTo(self.leftImageView.mas_trailing).inset(kRatio(4));
        make.trailing.equalTo(self.contentBgView).inset(kRatio(16));
    }];
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = [UIColor colorWithHex:0xFEE5F1];
        _contentBgView.layer.cornerRadius = kRatio(10);
        _contentBgView.layer.masksToBounds = YES;
    }
    return _contentBgView;
}

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = kGetImage(@"icon_auth_bank_tips");
    }
    return _leftImageView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kBlackColor;
        _contentLabel.font = kFont(10);
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"After your confirmation,this account will be used as a receipt account to receive the funds";
    }
    return _contentLabel;
}

@end

NS_ASSUME_NONNULL_END
