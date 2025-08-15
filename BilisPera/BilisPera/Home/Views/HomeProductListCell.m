//
//  HomeProductListCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "HomeProductListCell.h"

NS_ASSUME_NONNULL_BEGIN
@implementation HomeProductListCellModel

- (instancetype)initWith:(NSString *) title rate:(NSString *)rate duration:(NSString *)duration amount:(NSString *)amount completion:(nullable simpleStringCompletion)completion
{
    self = [super init];
    if (self) {
        self.title = title;
        self.rate = rate;
        self.duration = duration;
        self.amount = amount;
        self.completion = completion;
    }
    return self;
}

@end

@interface HomeProductListCell ()

@property (nonatomic, strong) HomeProductListCellModel *model;
@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *amountTitleLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *rateLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *loanButton;

@end

@implementation HomeProductListCell

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
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
        make.top.equalTo(self.contentView).offset(kRatio(12));
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.contentBgView addSubview:self.productImageView];
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentBgView).offset(kRatio(7));
        make.leading.equalTo(self.contentBgView).offset(kRatio(18));
        make.width.height.mas_equalTo(kRatio(26));
    }];
    
    [self.contentBgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading
            .equalTo(self.productImageView.mas_trailing)
            .inset(kRatio(10));
        make.top.equalTo(self.contentBgView).inset(kRatio(13));
    }];
    
    [self.contentBgView addSubview:self.rateLabel];
    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing
            .equalTo(self.contentBgView.mas_trailing)
            .inset(kRatio(12));
        make.centerY.equalTo(self.titleLabel);
        make.leading.equalTo(self.titleLabel.mas_trailing).offset(kRatio(10));
    }];
    
    [self.contentBgView addSubview:self.amountTitleLabel];
    [self.amountTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentBgView).inset(kRatio(20));
        make.top.equalTo(self.contentBgView).offset(kRatio(40));
    }];
    
    [self.contentBgView addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentBgView).inset(kRatio(18));
        make.top.equalTo(self.amountTitleLabel.mas_bottom).offset(kRatio(2));
        make.bottom.equalTo(self.contentBgView.mas_bottom).inset(kRatio(5));
    }];
    
    [self.contentBgView addSubview:self.loanButton];
    [self.loanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentBgView).inset(kRatio(8));
        make.centerY.equalTo(self.amountLabel);
        make.width.mas_equalTo(kRatio(110));
        make.height.mas_equalTo(kRatio(29));
    }];
    
    [self.contentBgView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
    [self.contentBgView addGestureRecognizer:tapGR];
}

-(void)tapEvent{
    if (self.model.completion) {
        self.model.completion(self.model.productId);
    }
}

- (void)setModel:(HomeProductListCellModel *)model{
    _model = model;
    self.titleLabel.text = self.model.title;
    self.amountTitleLabel.text = @"Max Amount";
    self.amountLabel.text = self.model.amount;
    NSString *rateStr = [NSString stringWithFormat:@"%@%@%@",
                         self.model.rate,
                         @"  |  ",
                         self.model.duration];
    self.rateLabel.text = rateStr;
    self.amountTitleLabel.text = self.model.amountDesc;
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl] placeholderImage:kGetImage(@"icon_home_product")];
    [self.loanButton setTitle:self.model.buttonTitle forState:UIControlStateNormal];
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[HomeProductListCellModel class]]) {
        self.model = data;
    }
}


- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_FFE6F2;
        _contentBgView.layer.cornerRadius = kRatio(18);
        _contentBgView.layer.masksToBounds = YES;
    }
    return _contentBgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kColor_351E29;
        _titleLabel.font = kFont(16);
    }
    return _titleLabel;
}

-(UILabel *)amountTitleLabel{
    if (!_amountTitleLabel) {
        _amountTitleLabel = [[UILabel alloc] init];
        _amountTitleLabel.textColor = kColor_351E29;
        _amountTitleLabel.font = kFont(12);
        _amountTitleLabel.text = @"Max Amount";
    }
    return _amountTitleLabel;
}

-(UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.textColor = kColor_351E29;
        _amountLabel.font = kFontMedium(34);
    }
    return _amountLabel;
}

-(UILabel *)rateLabel{
    if (!_rateLabel) {
        _rateLabel = [[UILabel alloc] init];
        _rateLabel.textColor = kColor_81556D;
        _rateLabel.font = kFontSemibold(12);
    }
    return _rateLabel;
}

- (UIImageView *)productImageView{
    if (!_productImageView) {
        _productImageView = [[UIImageView alloc] init];
        _productImageView.image = kGetImage(@"icon_home_product");
    }
    return _productImageView;
}

- (UIButton *)loanButton{
    if (!_loanButton) {
        _loanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loanButton setBackgroundImage:kGetImage(@"icon_home_loan_bg") forState:UIControlStateNormal];
        [_loanButton setTitle:@"Loan Now" forState:UIControlStateNormal];
        [_loanButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _loanButton.titleLabel.font = kFont(16);
    }
    return _loanButton;
}

@end

NS_ASSUME_NONNULL_END
