//
//  BPProductAlertViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "BPProductAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPProductAlertViewControllerModel


@end

@interface BPProductAlertViewController ()

@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UIImageView *contentBgImageView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) BPAlertHeasderView *headerView;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation BPProductAlertViewController

- (instancetype)initWith:(BPProductAlertViewControllerModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self configUI];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.contentBgView.frame.size.height > 0) {
        [self.contentBgView setRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight  radius:kRatio(26)];
    }
}

-(void)configUI{
    self.view.backgroundColor = [UIColor clearColor];
    self.backButton.frame = self.view.bounds;
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(kRatio(343));
        make.bottom.equalTo(self.view);
    }];
    
    [self.contentBgView addSubview:self.contentBgImageView];
    [self.contentBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.contentBgView);
    }];
    
    [self.contentBgView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.contentBgView);
        make.height.mas_equalTo(kRatio(52));
    }];
    
    [self.contentBgView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentBgView);
        make.bottom.equalTo(self.contentBgView).inset(kRatio(19));
        make.height.mas_equalTo(kRatio(46));
        make.width.mas_equalTo(kRatio(224));
    }];
    
    [self.contentBgView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentBgView).offset(kRatio(78));
        make.leading.trailing.equalTo(self.contentBgView);
        make.bottom
            .equalTo(self.contentBgView).inset(kRatio(62));
    }];
}

-(void)tapEvent{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (BPAlertHeasderView *)headerView{
    if (!_headerView) {
        _headerView = [[BPAlertHeasderView alloc] initWithFrame:CGRectZero];
    }
    return _headerView;
}

- (UIImageView *)contentBgImageView{
    if (!_contentBgImageView) {
        _contentBgImageView = [[UIImageView alloc] init];
        _contentBgImageView.image = kGetImage(@"icon_product_alert_bg");
    }
    return _contentBgImageView;
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_FFDDE8;
    }
    return _contentBgView;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"Confirm" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _confirmButton.backgroundColor = kBlackColor;
        _confirmButton.layer.cornerRadius = kRatio(22);
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.titleLabel.font = kFont(16);
        [_confirmButton addTarget:self action:@selector(confimEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.backgroundColor = [UIColor colorWithHex:0x111111 alpha:0.6];
        [_backButton addTarget:self action:@selector(tapEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (void)setModel:(BPProductAlertViewControllerModel *)model{
    _model = model;
    self.headerView.model = model.headerModel;
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    CGFloat bottomSpace = self.model.needConfirm ? kRatio(75) : kRatio(62);
    if (model.contentView) {
        [self.contentView addSubview:model.contentView];
        [model.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.leading.trailing.equalTo(self.contentView);
            make.bottom
                .equalTo(self.contentView);
        }];
    }
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom
            .equalTo(self.contentBgView).inset(bottomSpace);;
    }];
    [self.contentBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRatio(78) + bottomSpace + model.contentHeight);
    }];
    [self.confirmButton setHidden:!self.model.needConfirm];
    [self.view setNeedsLayout];
}

-(void)confimEvent:(UIButton *)sender{
    if (self.model.confirmCompletion) {
        self.model.confirmCompletion();
    }
}
@end

NS_ASSUME_NONNULL_END
