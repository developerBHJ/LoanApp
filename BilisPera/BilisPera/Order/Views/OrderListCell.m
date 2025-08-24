//
//  OrderListCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/15.
//

#import "OrderListCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation OrderListCellModel

- (NSString *)typeImage{
    NSString *imageName = @"";
    switch (self.type) {
        case OrderListTypeDelay:
            imageName = @"icon_status_delay";
            break;
        case OrderListTypeRepayment:
            imageName = @"icon_status_repayment";
            break;
        case OrderListTypeReview:
            imageName = @"icon_status_review";
            break;
        case OrderListTypeFinish:
            imageName = @"icon_status_finish";
            break;
        case OrderListTypeApply:
            imageName = @"icon_status_apply";
            break;
    }
    return imageName;
}

- (UIColor *)typeBackColor{
    UIColor *bgColor = [UIColor clearColor];
    switch (self.type) {
        case OrderListTypeDelay:
            bgColor = [UIColor colorWithHex:0xF05060];
            break;
        case OrderListTypeRepayment:
            bgColor = [UIColor colorWithHex:0xFFB540];
            break;
        case OrderListTypeReview:
            bgColor = [UIColor colorWithHex:0xF05060];
            break;
        case OrderListTypeFinish:
            bgColor = [UIColor colorWithHex:0xF05060];
            break;
        case OrderListTypeApply:
            bgColor = [UIColor colorWithHex:0x9E5BFB];
            break;
    }
    return bgColor;
}

@end

@interface OrderListCell ()

@property (nonatomic, strong) OrderListCellModel *model;
@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *amountTitleLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIButton *loanButton;
@property (nonatomic, strong) UIButton *statusButton;
@property (nonatomic, strong) UIView *remindView;
@property (nonatomic, strong) UIImageView *remindImageView;
@property (nonatomic, strong) UILabel *remindLabel;

@end

@implementation OrderListCell

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
        make.top.equalTo(self.contentView).offset(kRatio(16));
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.statusButton];
    [self.statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRatio(12));
        make.trailing.equalTo(self.contentView).inset(kRatio(18));
        make.width.mas_equalTo(kRatio(84));
        make.height.mas_equalTo(kRatio(53));
    }];
    
    [self.contentBgView addSubview:self.productImageView];
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentBgView).offset(kRatio(8));
        make.leading.equalTo(self.contentBgView).offset(kRatio(13));
        make.width.height.mas_equalTo(kRatio(26));
    }];
    
    [self.contentBgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading
            .equalTo(self.productImageView.mas_trailing)
            .inset(kRatio(7));
        make.top.equalTo(self.contentBgView).inset(kRatio(13));
    }];
    
    [self.contentBgView addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentBgView).offset(kRatio(42));
        make.leading.equalTo(self.contentBgView).offset(kRatio(13));
        make.height.mas_greaterThanOrEqualTo(kRatio(51));
    }];
    
    [self.contentBgView addSubview:self.amountTitleLabel];
    [self.amountTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.amountLabel.mas_trailing);
        make.centerY.equalTo(self.amountLabel);
        make.trailing.greaterThanOrEqualTo(self.contentBgView).inset(120);
    }];
    
    [self.contentBgView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentBgView).inset(kRatio(13));
        make.top.equalTo(self.amountLabel.mas_bottom);
    }];
    
    [self.contentBgView addSubview:self.remindView];
    [self.remindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentBgView).inset(kRatio(12));
        make.top.equalTo(self.dateLabel.mas_bottom).offset(kRatio(10));
        make.bottom.equalTo(self.contentBgView.mas_bottom).offset(-kRatio(7));
        make.trailing.equalTo(self.contentBgView).inset(kRatio(12));
        make.height.mas_equalTo(kRatio(24));
    }];
    
    [self.contentBgView addSubview:self.loanButton];
    [self.loanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.amountLabel.mas_bottom);
        make.trailing.equalTo(self.contentBgView).inset(kRatio(2));
        make.height.mas_equalTo(kRatio(32));
        make.width.mas_equalTo(kRatio(117));
    }];
    
    [self.remindView addSubview:self.remindImageView];
    [self.remindImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.remindView).inset(kRatio(16));
        make.centerY.equalTo(self.remindView);
        make.width.height.mas_equalTo(kRatio(15));
    }];
    
    [self.remindView addSubview:self.remindLabel];
    [self.remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.remindImageView.mas_trailing).inset(kRatio(5));
        make.centerY.equalTo(self.remindView);
        make.trailing.equalTo(self.remindView.mas_trailing).inset(kRatio(35));
    }];
    
    [self.contentBgView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
    [self.contentBgView addGestureRecognizer:tapGR];
}

-(void)tapEvent{
    if (self.model.completion) {
        self.model.completion(self.model.linkUrl);
    }
}

- (void)setModel:(OrderListCellModel *)model{
    _model = model;
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl] placeholderImage:kGetImage(@"icon_home_product")];
    self.titleLabel.text = self.model.name;
    self.amountLabel.text = self.model.amount;
    self.amountTitleLabel.text = self.model.amountDesc;
    self.dateLabel.text = self.model.dateStr;
    self.remindLabel.text = self.model.remind;
    [self.statusButton setTitle:self.model.status forState:UIControlStateNormal];
    [self.statusButton setBackgroundImage:kGetImage(self.model.typeImage) forState:UIControlStateNormal];
    UIImage *loanImage = [[UIImage imageNamed:@"icon_home_loan_bg"] imageWithTintColor:self.model.typeBackColor];
    [self.loanButton setBackgroundImage:loanImage forState:UIControlStateNormal];
    [self.loanButton setTitle:self.model.buttonTitle forState:UIControlStateNormal];
    [self.remindView setHidden: self.model.type != OrderListTypeDelay  && self.model.type != OrderListTypeRepayment];
    [self.loanButton setHidden: self.model.type == OrderListTypeReview  || self.model.type == OrderListTypeFinish];
    CGFloat buttonWidth = [self.model.status getWidthWithFont:kFont(16) height:kRatio(20)] + kRatio(13);
    [self.statusButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(buttonWidth);
    }];
    if (self.remindView.isHidden) {
        [self.remindView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
            make.top.equalTo(self.dateLabel.mas_bottom);
            make.bottom
                .equalTo(self.contentBgView.mas_bottom)
                .offset(-kRatio(10));
        }];
    }else{
        [self.remindView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(24);
            make.top.equalTo(self.dateLabel.mas_bottom).offset(kRatio(10));
            make.bottom
                .equalTo(self.contentBgView.mas_bottom)
                .offset(-kRatio(7));
        }];
    }
    if (self.model.type == OrderListTypeReview  || self.model.type == OrderListTypeFinish) {
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        [self.amountTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top
                .equalTo(self.productImageView.mas_bottom)
                .offset(kRatio(10));
            make.leading.equalTo(self.contentBgView).offset(kRatio(13));
        }];
        [self.amountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.amountTitleLabel.mas_bottom);
            make.leading.equalTo(self.contentBgView).offset(kRatio(13));
            make.trailing.equalTo(self.contentBgView.mas_centerX);
            make.height.mas_greaterThanOrEqualTo(kRatio(51));
            make.bottom.equalTo(self.contentBgView);
        }];
        [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.contentBgView).inset(kRatio(12));
            make.leading
                .equalTo(self.contentBgView.mas_centerX)
                .offset(-kRatio(5));
        }];
    }else{
        self.dateLabel.textAlignment = NSTextAlignmentLeft;
        [self.amountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentBgView).offset(kRatio(42));
            make.leading.equalTo(self.contentBgView).offset(kRatio(13));
            make.height.mas_greaterThanOrEqualTo(kRatio(51));
        }];
        
        [self.amountTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.amountLabel.mas_trailing);
            make.centerY.equalTo(self.amountLabel);
            make.trailing.greaterThanOrEqualTo(self.contentBgView).inset(120);
        }];
        
        [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentBgView).inset(kRatio(13));
            make.top.equalTo(self.amountLabel.mas_bottom);
        }];
    }
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[OrderListCellModel class]]) {
        self.model = data;
    }
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_FFDDE8;
        _contentBgView.layer.cornerRadius = kRatio(16);
        _contentBgView.layer.masksToBounds = YES;
        _contentBgView.layer.borderColor = kBlackColor.CGColor;
        _contentBgView.layer.borderWidth = 1.0;
    }
    return _contentBgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFont(16);
    }
    return _titleLabel;
}

-(UILabel *)amountTitleLabel{
    if (!_amountTitleLabel) {
        _amountTitleLabel = [[UILabel alloc] init];
        _amountTitleLabel.textColor = kBlackColor;
        _amountTitleLabel.font = kFont(14);
        _amountTitleLabel.text = @"Max Amount";
    }
    return _amountTitleLabel;
}

-(UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.textColor = kBlackColor;
        _amountLabel.font = kFontMedium(32);
    }
    return _amountLabel;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = kBlackColor;
        _dateLabel.font = kFontMedium(12);
    }
    return _dateLabel;
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

- (UIView *)remindView{
    if (!_remindView) {
        _remindView = [[UIView alloc] init];
        _remindView.backgroundColor = kWhiteColor;
        _remindView.layer.cornerRadius = kRatio(12);
        _remindView.layer.masksToBounds = YES;
        [_remindView setHidden:YES];
    }
    return _remindView;
}

- (UIImageView *)remindImageView{
    if (!_remindImageView) {
        _remindImageView = [[UIImageView alloc] init];
        _remindImageView.image = kGetImage(@"icon_order_tips");
    }
    return _remindImageView;
}

- (UILabel *)remindLabel{
    if (!_remindLabel) {
        _remindLabel = [[UILabel alloc] init];
        _remindLabel.textColor = kColor_FF3888;
        _remindLabel.font = kFontMedium(12);
    }
    return _remindLabel;
}

- (UIButton *)statusButton{
    if (!_statusButton) {
        _statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_statusButton setBackgroundImage:kGetImage(@"icon_status_delay") forState:UIControlStateNormal];
        [_statusButton setTitle:@"" forState:UIControlStateNormal];
        [_statusButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _statusButton.titleLabel.font = kFont(16);
        [_statusButton setUserInteractionEnabled:NO];
        [_statusButton setTitleEdgeInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
    }
    return _statusButton;
}


@end

NS_ASSUME_NONNULL_END
