//
//  HomeHeaderCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/13.
//

#import "HomeHeaderCell.h"
#import "BPLayoutButton.h"

NS_ASSUME_NONNULL_BEGIN

@implementation HomeHeaderCellModel


@end

@interface HomeHeaderCell ()

@property (nonatomic, strong) UIImageView *contentBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) BPLayoutButton *loanRateView;
@property (nonatomic, strong) BPLayoutButton *loanDurationView;
@property (nonatomic, strong) UIImageView *amountUnitImageView;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) HomeHeaderCellModel *model;
@property (nonatomic, strong) BPLayoutButton *nextButton;

@end


@implementation HomeHeaderCell

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
        make.top.equalTo(self.contentView);
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.contentBgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentBgView).offset(kRatio(10));
        make.leading.equalTo(self.contentBgView).offset(kRatio(8));
        make.trailing.equalTo(self.contentBgView).offset(-kRatio(108));
    }];
    
    [self.contentBgView addSubview:self.loanRateView];
    [self.loanRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(10));
        make.leading.equalTo(self.contentBgView).offset(kRatio(10));
        make.height.mas_equalTo(kRatio(24));
        make.width.mas_greaterThanOrEqualTo(kRatio(100));
    }];
    
    [self.contentBgView addSubview:self.loanDurationView];
    [self.loanDurationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(10));
        make.leading.equalTo(self.loanRateView.mas_trailing).offset(kRatio(10));
        make.height.mas_equalTo(kRatio(24));
        make.width.mas_greaterThanOrEqualTo(kRatio(100));
    }];
    
    [self.contentBgView addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loanRateView.mas_bottom).offset(kRatio(6));
        make.leading.equalTo(self.contentBgView).offset(kRatio(44));
        make.trailing.equalTo(self.contentBgView).offset(-kRatio(60));
        make.bottom.equalTo(self.contentBgView).offset(-kRatio(66));
    }];
    
    [self.contentBgView addSubview:self.amountUnitImageView];
    [self.amountUnitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.amountLabel.mas_centerY);
        make.leading.equalTo(self.contentBgView).offset(kRatio(10));
        make.height.mas_equalTo(kRatio(26));
        make.width.mas_equalTo(kRatio(23));
    }];
    
    [self.contentBgView addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.amountLabel.mas_bottom).offset(kRatio(5));
        make.leading.equalTo(self.contentBgView).offset(kRatio(18));
        make.height.mas_equalTo(kRatio(40));
        make.width.mas_equalTo(kRatio(220));
    }];
    
    [self setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
    [self addGestureRecognizer:tapGR];
}

-(void)setModel:(HomeHeaderCellModel *)model{
    _model = model;
    self.titleLabel.text = self.model.title;
    [self.loanRateView setTitle:self.model.rate forState:UIControlStateNormal];
    [self.loanDurationView setTitle:self.model.duration forState:UIControlStateNormal];
    self.amountLabel.text = self.model.amount;
    [self.nextButton setTitle:self.model.buttonTitle forState:UIControlStateNormal];
}

-(void)tapEvent{
    if (self.model.completion) {
        self.model.completion(self.model.productId);
    }
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[HomeHeaderCellModel class]]) {
        self.model = data;
    }
}

- (UIImageView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIImageView alloc] init];
        _contentBgView.image = kGetImage(@"icon_home_header_bg");
    }
    return _contentBgView;
}

- (UIImageView *)amountUnitImageView{
    if (!_amountUnitImageView) {
        _amountUnitImageView = [[UIImageView alloc] init];
        _amountUnitImageView.image = kGetImage(@"icon_home_unit");
    }
    return _amountUnitImageView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFontSemibold(18);
    }
    return _titleLabel;
}

-(UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.textColor = kWhiteColor;
        _amountLabel.font = kFont(54);
    }
    return _amountLabel;
}

-(BPLayoutButton *)loanRateView{
    if (!_loanRateView) {
        _loanRateView = [BPLayoutButton buttonWithType:UIButtonTypeCustom];
        _loanRateView.layoutStyle = BPLayoutButtonStyleLeftImageRightTitle;
        [_loanRateView setTitle:@"" forState:UIControlStateNormal];
        [_loanRateView setImage:kGetImage(@"icon_home_rate") forState:UIControlStateNormal];
        [_loanRateView setTitleColor:kBlackColor forState:UIControlStateNormal];
        _loanRateView.titleLabel.font = kFont(12);
        _loanRateView.backgroundColor = kColor_FFEDF5;
        _loanRateView.layer.cornerRadius = kRatio(12);
        _loanRateView.layer.masksToBounds = YES;
        _loanRateView.layer.borderColor = kBlackColor.CGColor;
        _loanRateView.layer.borderWidth = 1.0;
    }
    return _loanRateView;
}

-(BPLayoutButton *)loanDurationView{
    if (!_loanDurationView) {
        _loanDurationView = [BPLayoutButton buttonWithType:UIButtonTypeCustom];
        _loanDurationView.layoutStyle = BPLayoutButtonStyleLeftImageRightTitle;
        [_loanDurationView setTitle:@"" forState:UIControlStateNormal];
        [_loanDurationView setImage:kGetImage(@"icon_home_duration") forState:UIControlStateNormal];
        [_loanDurationView setTitleColor:kBlackColor forState:UIControlStateNormal];
        _loanDurationView.titleLabel.font = kFont(12);
        _loanDurationView.backgroundColor = kColor_FFEDF5;
        _loanDurationView.layer.cornerRadius = kRatio(12);
        _loanDurationView.layer.masksToBounds = YES;
        _loanDurationView.layer.borderColor = kBlackColor.CGColor;
        _loanDurationView.layer.borderWidth = 1.0;
    }
    return _loanDurationView;
}

-(BPLayoutButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [BPLayoutButton buttonWithType:UIButtonTypeCustom];
        _nextButton.layoutStyle = BPLayoutButtonStyleLeftTitleRightImage;
        _nextButton.midSpacing = kRatio(8);
        [_nextButton setTitle:@"Click to view" forState:UIControlStateNormal];
        [_nextButton setImage:kGetImage(@"icon_home_arrow") forState:UIControlStateNormal];
        [_nextButton setTitleColor:kBlackColor forState:UIControlStateNormal];
        _nextButton.titleLabel.font = kFont(16);
        _nextButton.backgroundColor = [UIColor clearColor];
    }
    return _nextButton;
}
@end

NS_ASSUME_NONNULL_END
