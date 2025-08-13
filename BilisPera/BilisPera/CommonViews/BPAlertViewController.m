//
//  BPAlertViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/13.
//

#import "BPAlertViewController.h"
#import "PrivacyView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPAlertViewModel

- (instancetype)initWith:(BPAlertViewType)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (NSString *)title{
    NSString *name = @"";
    switch (self.type) {
        case BPAlertViewTypeStay:
            name = @"Great value offers !";
            break;
        case BPAlertViewTypeExit:
            name = @"Are you really\nquitting the APP?";
            break;
        case BPAlertViewTypeCancellation:
            name = @"log up！";
            break;
        case BPAlertViewTypeReloan:
            name = @"High Quality Products";
            break;
    }
    return name;
}

- (NSString *)content{
    NSString *name = @"";
    switch (self.type) {
        case BPAlertViewTypeStay:
            name = @"Binding information can help obtain loans faster You can register information to improve your acquisition speed faster and develop your plan";
            break;
        case BPAlertViewTypeExit:
            name = @"It suits your financial situation and makes repayment stress-free. Come back quickly to bind and embark on the path of low-cost loans!";
            break;
        case BPAlertViewTypeCancellation:
            name = @"You Are About To log Out Is There Anything You Are Not Satisfied with?Please Leave Your Valuable Suggestions So That We Can Do Better, Don't Go, Please";
            break;
        case BPAlertViewTypeReloan:
            name = @"VIP lane available, acc rate up to 99%, click to apply";
            break;
    }
    return name;
}

- (NSString *)confirmBtnTitle{
    NSString *name = @"";
    switch (self.type) {
        case BPAlertViewTypeStay:
            name = @"Confirm";
            break;
        case BPAlertViewTypeExit:
            name = @"Log Out";
            break;
        case BPAlertViewTypeCancellation:
            name = @"Log Off";
            break;
        case BPAlertViewTypeReloan:
            name = @"Go Apply";
            break;
    }
    return name;
}

- (NSString *)cancelBtnTitle{
    NSString *name = @"Cancel";
    switch (self.type) {
        case BPAlertViewTypeReloan:
            name = @"Apply Product";
            break;
        default:
            name = @"Cancel";
            break;
    }
    return name;
}

@end

@interface BPAlertViewController ()

@property (nonatomic, strong) UIImageView *contentBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) PrivacyView *privacyView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation BPAlertViewController

- (instancetype)initWith:(BPAlertViewModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:0x080811 alpha:0.5];
    [self configUI];
}

-(void)configUI{
    [self.view addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view).inset(kRatio(6));
        make.centerY.equalTo(self.view);
        make.height.mas_greaterThanOrEqualTo(kRatio(442));
    }];
    [self.contentBgView setUserInteractionEnabled:YES];
    [self.contentBgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentBgView).inset(kRatio(65));
        make.top.equalTo(self.contentBgView).offset(kRatio(103));
    }];
    
    [self.contentBgView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentBgView).inset(kRatio(65));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(16));
        make.bottom
            .greaterThanOrEqualTo(self.contentBgView.mas_bottom)
            .inset(kRatio(153));
    }];
    [self.contentBgView addSubview:self.confirmButton];
    [self.contentBgView addSubview:self.cancelButton];
    if (self.model.type == BPAlertViewTypeExit || self.model.type == BPAlertViewTypeCancellation) {
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentBgView);
            make.bottom
                .equalTo(self.contentBgView.mas_bottom)
                .inset(kRatio(20));
            make.height.mas_equalTo(kRatio(42));
            make.width.mas_equalTo(kRatio(214));
        }];
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentBgView);
            make.bottom.equalTo(self.confirmButton.mas_top).inset(kRatio(9));
            make.height.mas_equalTo(kRatio(42));
            make.width.mas_equalTo(kRatio(214));
        }];
        [self updateSelectedButton:self.cancelButton];
    }else{
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentBgView);
            make.bottom
                .equalTo(self.contentBgView.mas_bottom)
                .inset(kRatio(20));
            make.height.mas_equalTo(kRatio(42));
            make.width.mas_equalTo(kRatio(214));
        }];
        [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentBgView);
            make.bottom.equalTo(self.cancelButton.mas_top).inset(kRatio(9));
            make.height.mas_equalTo(kRatio(42));
            make.width.mas_equalTo(kRatio(214));
        }];
        [self updateSelectedButton:self.confirmButton];
    }
    [self.contentLabel setContentHuggingPriority:UILayoutConstraintAxisVertical forAxis:UILayoutPriorityDefaultHigh];
    if (self.model.type == BPAlertViewTypeCancellation) {
        [self.contentBgView addSubview:self.privacyView];
        [self.privacyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentBgView);
            make.bottom.equalTo(self.cancelButton.mas_top).inset(kRatio(24));
            make.height.mas_equalTo(kRatio(24));
            make.width.mas_greaterThanOrEqualTo(kRatio(240));
        }];
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom
                .greaterThanOrEqualTo(self.contentBgView.mas_bottom)
                .inset(kRatio(177));
        }];
        kWeakSelf;
        self.privacyView.model.checkBoxCompletion = ^(BOOL selected) {
            if (weakSelf.model.selectedCompletion) {
                weakSelf.model.selectedCompletion(selected);
            }
        };
    }
    self.titleLabel.text = self.model.title;
    self.contentLabel.text = self.model.content;
    [self.confirmButton setTitle:self.model.confirmBtnTitle forState:UIControlStateNormal];
    [self.cancelButton setTitle:self.model.cancelBtnTitle forState:UIControlStateNormal];
}

- (UIImageView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIImageView alloc] init];
        _contentBgView.image = kGetImage(@"icon_alert_bg");
    }
    return _contentBgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kColor_FF9C00;
        _titleLabel.font = [UIFont systemFontOfSize:kRatio(26) weight:UIFontWeightSemibold];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kColor_5B2941;
        _contentLabel.font = kFontMedium(16);
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

- (PrivacyView *)privacyView{
    if (!_privacyView) {
        PrivacyViewModel *model = [[PrivacyViewModel alloc] init];
        model. tapModel.regluarText = @"I've read and agreed with the above.";
        model.tapModel.linkText = @"";
        model.isAlert = YES;
        _privacyView = [[PrivacyView alloc] initWithFrame:CGRectZero model:model];
    }
    return _privacyView;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton addTarget:self action:@selector(confirmEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton setTitle:@"Confirm" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kColor_979797 forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = kFont(18);
    }
    return _confirmButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton addTarget:self action:@selector(cancelEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:kColor_979797 forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = kFont(18);
    }
    return _cancelButton;
}

-(void)confirmEvent:(UIButton *)sender{
    if (self.model.confirmCompletion) {
        self.model.confirmCompletion();
    }
    [self updateSelectedButton:sender];
}

-(void)cancelEvent:(UIButton *)sender{
    if (self.model.cancelCompletion) {
        self.model.cancelCompletion();
    }
    [self updateSelectedButton:sender];
}

-(void)updateSelectedButton:(UIButton *)sender{
    if (self.selectedButton == sender) {
        return;
    }
    [sender setTitleColor:kBlackColor forState:UIControlStateNormal];
    [self.selectedButton setTitleColor:kColor_979797 forState:UIControlStateNormal];
    sender.layer.borderColor = kBlackColor.CGColor;
    sender.layer.borderWidth = 1.0;
    sender.layer.cornerRadius = kRatio(21);
    sender.layer.masksToBounds = YES;
    sender.backgroundColor = kColor_F7BCDE;
    self.selectedButton.layer.borderWidth = 0;
    self.selectedButton.layer.cornerRadius = 0;
    self.selectedButton.backgroundColor = [UIColor clearColor];
    self.selectedButton = sender;
}

@end

NS_ASSUME_NONNULL_END
