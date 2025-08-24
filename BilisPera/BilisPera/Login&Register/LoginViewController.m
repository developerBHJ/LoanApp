//
//  LoginViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "LoginInputView.h"
#import "PrivacyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController()

@property (nonatomic, strong) LoginViewModel *viewModel;
@property (nonatomic, strong) LoginInputView *phoneView;
@property (nonatomic, strong) LoginInputView *codeView;
@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) PrivacyView *privacyView;

@end

@implementation LoginViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"";
    self.viewModel = [[LoginViewModel alloc] init];
    [self configUI];
    [self checkComplete];
    [[BPADTools shared] registerIDFAAndTrack];
}


-(LoginInputView *)phoneView{
    if (!_phoneView) {
        _phoneView = [[LoginInputView alloc] initWithFrame:CGRectZero text:@"" placeHolder:@"Enter mobile number" needLeftView:YES needRightView:NO sendCode:nil];
    }
    return  _phoneView;
}

-(LoginInputView *)codeView{
    if (!_codeView) {
        kWeakSelf;
        _codeView = [[LoginInputView alloc] initWithFrame:CGRectZero text:@"" placeHolder:@"Please enter verification code" needLeftView:NO needRightView:YES sendCode:^{
            [weakSelf getVerifyCode];
        }];
    }
    return  _codeView;
}

- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.image = kGetImage(@"icon_logo");
    }
    return _topImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFontMedium(20);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"Bilis  Pera";
    }
    return  _titleLabel;
}

- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = kColor_727272;
        _subTitleLabel.font = kFontBold(12);
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.text = @"Special offer on the first loan";
    }
    return  _subTitleLabel;
}

- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [_loginButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _loginButton.titleLabel.font = kFont(18);
        _loginButton.backgroundColor = kColor_351E29;
        _loginButton.layer.cornerRadius = kRatio(14);
        _loginButton.layer.masksToBounds = true;
        [_loginButton addTarget:self action:@selector(loginEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (PrivacyView *)privacyView{
    if (!_privacyView) {
        PrivacyViewModel *model = [[PrivacyViewModel alloc] init];
        model.isAgree = YES;
        model. tapModel.regluarText = @"By logging in, you agree to the ";
        model.tapModel.linkText = @"Privacy Agreement";
        model.tapModel.linkUrl = [[HtmlPath getUrl:BPHtmlPathPrivacy] absoluteString];
        model.tapModel.tapCompletion = ^(NSString * url) {
            [[Routes shared] onPushWebView:url];
        };
        _privacyView = [[PrivacyView alloc] initWithFrame:CGRectZero model:model];
    }
    return _privacyView;
}

-(void)configUI{
    [self.view addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kRatio(25) + kNavigationBarHeight);
        make.centerX.equalTo(self.view);
        make.width.height.mas_equalTo(kRatio(78));
    }];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).offset(kRatio(14));
        make.leading.trailing.equalTo(self.view).inset(kRatio(16));
    }];
    
    [self.view addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(6));
        make.leading.trailing.equalTo(self.view).inset(kRatio(16));
    }];
    
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.codeView];
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(kRatio(88));
        make.leading.trailing.equalTo(self.view).inset(kRatio(16));
        make.height.mas_equalTo(kRatio(60));
    }];
    
    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneView.mas_bottom).offset(kRatio(30));
        make.leading.trailing.equalTo(self.view).inset(kRatio(16));
        make.height.mas_equalTo(kRatio(60));
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeView.mas_bottom).offset(kRatio(120));
        make.leading.trailing.equalTo(self.view).inset(kRatio(44));
        make.height.mas_equalTo(kRatio(52));
    }];
    
    [self.view addSubview:self.privacyView];
    [self.privacyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom
            .equalTo(self.view.mas_bottom)
            .offset(-kSafeAreaBottomHeight - kRatio(39));
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(kRatio(20));
        make.width.mas_greaterThanOrEqualTo(kRatio(270));
    }];
    
    kWeakSelf;
    self.phoneView.didEndEditting = ^(NSString * value){
        weakSelf.viewModel.phoneNum = value;
        [weakSelf checkComplete];
    };
    
    self.codeView.didEndEditting = ^(NSString * value){
        weakSelf.viewModel.code = value;
        [weakSelf checkComplete];
    };
    
    self.privacyView.model.checkBoxCompletion = ^(BOOL checked) {
        weakSelf.viewModel.isAgress = checked;
        [weakSelf.view endEditing:YES];
        [weakSelf checkComplete];
    };
}

-(void)checkComplete{
    BOOL isCompleted = [self.viewModel checkCompletion];
    UIColor *bgColor = isCompleted ? kColor_351E29 : kColor_929292;
    [self.loginButton setBackgroundColor:bgColor];
    [self.loginButton setEnabled:isCompleted];
}

-(void)getVerifyCode{
    kWeakSelf;
    [self.view endEditing:YES];
    [[TrackTools shared]saveTrackTime:BPTrackRiskTypeRegister start:YES];
    if ( [[BPADTools shared] trackCount] < 2){
        [[TrackTools shared] trackForGoogleMarket];
        [BPADTools shared].trackCount += 1;
    }
    [self.viewModel getVerifyCodeWithCompletion:^(BOOL sucdess) {
        if (sucdess) {
            [weakSelf.codeView cutDown];
        }
    }];
}

-(void)loginEvent{
    [self.view endEditing:YES];
    kWeakSelf;
    [self.viewModel loginWithCompletion:^(BOOL success) {
        if (success) {
            [[TrackTools shared]saveTrackTime:BPTrackRiskTypeRegister start:NO];
            if (weakSelf.completion) {
                weakSelf.completion();
            }
            [[Routes shared] changeRootView];
        }
    }];
}


@end

NS_ASSUME_NONNULL_END
