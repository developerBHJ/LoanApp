//
//  ProductHomeHeaderView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/16.
//

#import "ProductHomeHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProductHomeHeaderViewModel


@end

@interface ProductHomeHeaderView ()

@property (nonatomic, strong) ProductHomeHeaderViewModel *model;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *amountTitleLabel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *lineView;

@end


@implementation ProductHomeHeaderView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRatio(10));
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
        make.bottom.equalTo(self.contentView).inset(kRatio(10));
    }];
    
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(12));
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(kRatio(40));
    }];
    
    [self.bottomView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.bottomView);
        make.bottom.equalTo(self.bottomView);
        make.height.mas_equalTo(kRatio(1));
    }];
    [self.contentBgView addSubview:self.productImageView];
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentBgView).offset(kRatio(15));
        make.top.equalTo(self.contentBgView).offset(kRatio(17));
        make.width.height.mas_equalTo(kRatio(51));
    }];
    
    [self.contentBgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading
            .equalTo(self.productImageView.mas_trailing)
            .offset(kRatio(10));
        make.top.equalTo(self.contentBgView).offset(kRatio(14));
        make.trailing
            .equalTo(self.contentBgView.mas_trailing)
            .offset(-kRatio(10));
    }];
    
    [self.contentBgView addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.trailing
            .equalTo(self.contentBgView.mas_trailing)
            .offset(-kRatio(100));
        make.height.mas_greaterThanOrEqualTo(kRatio(63));
        make.bottom.equalTo(self.contentBgView).inset(kRatio(30));
    }];
    
    [self.bottomView addSubview:self.amountTitleLabel];
    [self.amountTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bottomView).offset(kRatio(14));
        make.centerY.equalTo(self.bottomView);
        make.trailing
            .equalTo(self.bottomView.mas_trailing)
            .offset(-kRatio(100));
    }];
    
    [self.contentView addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRatio(30));
        make.trailing
            .equalTo(self.contentView.mas_trailing)
            .offset(-kRatio(16));
        make.width.mas_equalTo(kRatio(82));
        make.height.mas_equalTo(kRatio(93));
    }];
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_351E29;
        _contentBgView.layer.cornerRadius = kRatio(10);
        _contentBgView.layer.masksToBounds = YES;
    }
    return _contentBgView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = kColor_F7BCDE;
    }
    return _bottomView;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kColor_351E29;
    }
    return _lineView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kWhiteColor;
        _titleLabel.font = kFont(16);
    }
    return _titleLabel;
}

-(UILabel *)amountTitleLabel{
    if (!_amountTitleLabel) {
        _amountTitleLabel = [[UILabel alloc] init];
        _amountTitleLabel.textColor = kWhiteColor;
        _amountTitleLabel.font = kFont(22);
    }
    return _amountTitleLabel;
}

-(UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.textColor = kWhiteColor;
        _amountLabel.font = kFontMedium(42);
    }
    return _amountLabel;
}

- (UIImageView *)productImageView{
    if (!_productImageView) {
        _productImageView = [[UIImageView alloc] init];
    }
    return  _productImageView;
}

- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
    }
    return  _rightImageView;
}

- (void)setModel:(ProductHomeHeaderViewModel *)model{
    _model = model;
    self.titleLabel.text = self.model.name;
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl] placeholderImage:kGetImage(@"icon_home_product")];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.model.rightImageName]];
    self.amountLabel.text = self.model.amount;
    self.amountTitleLabel.text = self.model.amountDesc.length > 0 ? self.model.amountDesc : @"Low-interest loans！";
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[ProductHomeHeaderViewModel class]]) {
        self.model = data;
    }
}

@end

NS_ASSUME_NONNULL_END
