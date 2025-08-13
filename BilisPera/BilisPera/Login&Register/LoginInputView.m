//
//  LoginInputView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/9.
//

#import "LoginInputView.h"
#import "CountDownButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginInputView ()<UITextFieldDelegate,CountDownButtonDelegate,CountDownButtonDataSource>

@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UILabel *countryCodeLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) CountDownButton *codeButton;

@property (nonatomic, assign)BOOL needLeftView;
@property (nonatomic, assign)BOOL needRightView;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *placeHolder;

@property (nonatomic, copy) sendCodeCompletion sendCode;

@end

@implementation LoginInputView

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text placeHolder:(NSString *)placeHolder needLeftView:(BOOL)needLeftView needRightView:(BOOL)needRightView sendCode:(nullable sendCodeCompletion)sendCode
{
    self = [super initWithFrame:frame];
    if (self) {
        self.needLeftView = needLeftView;
        self.needRightView = needRightView;
        self.sendCode = sendCode;
        self.text = text;
        self.placeHolder = placeHolder;
        [self configUI];
    }
    return self;
}

- (UITextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.delegate = self;
        _inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return  _inputTextField;
}

-(UILabel *)countryCodeLabel{
    if (!_countryCodeLabel) {
        _countryCodeLabel = [[UILabel alloc] init];
        _countryCodeLabel.font = kFont(16);
        _countryCodeLabel.textColor = kBlackColor;
        _countryCodeLabel.textAlignment = NSTextAlignmentCenter;
        _countryCodeLabel.text = @"+63";
    }
    return _countryCodeLabel;
}

-(CountDownButton *)codeButton{
    if (!_codeButton) {
        _codeButton = [[CountDownButton alloc] init];
        [_codeButton setAttributedTitle:[@"Code" addUnderline] forState:UIControlStateNormal];
        [_codeButton setTitleColor:kBlackColor forState:UIControlStateNormal];
        _codeButton.titleLabel .font = kFont(16);
        [_codeButton addTarget:self action:@selector(sendCodeEvent) forControlEvents:UIControlEventTouchUpInside];
        _codeButton.delegate = self;
        _codeButton.dataSource = self;
    }
    return  _codeButton;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kColor_929292;
    }
    return _lineView;
}

- (UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc] init];
    }
    return _leftView;
}

- (UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc] init];
    }
    return _rightView;
}

-(void)configUI{
    self.layer.cornerRadius = kRatio(30);
    self.layer.masksToBounds = true;
    self.layer.borderColor = kBlackColor.CGColor;
    self.layer.borderWidth = 1.0;
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    [self addSubview:self.inputTextField];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.leading.equalTo(self).inset(kRatio(20));
        make.width.mas_equalTo(0);
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.trailing.equalTo(self).inset(kRatio(20));
        make.width.mas_equalTo(0);
    }];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.leading.equalTo(self.leftView.mas_trailing);
        make.trailing.equalTo(self.rightView.mas_leading);
    }];
    
    self.inputTextField.text = self.text;
    self.inputTextField.placeholder = self.placeHolder;
    if (self.needLeftView) {
        [self.leftView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kRatio(46));
        }];
        [self.leftView addSubview:self.countryCodeLabel];
        [self.countryCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.leftView);
            make.leading.equalTo(self.leftView);
        }];
        [self.leftView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.leftView);
            make.trailing.equalTo(self.leftView).offset(-kRatio(10));
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(kRatio(20));
            make.leading
                .equalTo(self.countryCodeLabel.mas_trailing)
                .offset(kRatio(5));
        }];
    }
    if (self.needRightView) {
        [self.rightView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kRatio(46));
        }];
        [self.rightView addSubview:self.codeButton];
        [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.rightView);
            make.leading.equalTo(self.rightView).offset(kRatio(4));
            make.trailing
                .equalTo(self.rightView.mas_trailing);
        }];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.didEndEditting(textField.text ?: @"");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

-(void)cutDown{
        [self.codeButton startCountDown];
}

-(void)sendCodeEvent{
    self.sendCode();
}
#pragma mark - CountDownButton Delegate
//- (void)countDownButtonDidClick:(CountDownButton *)countDownButton {
//    [self.codeButton startCountDown];
//}

- (void)countDownButtonDidStartCountDown:(CountDownButton *)countDownButton {
    
}

- (void)countDownButtonDidInCountDown:(CountDownButton *)countDownButton withRestCountDownNum:(NSInteger)restCountDownNum {
    NSString *title = [NSString stringWithFormat:@"%ldS",
                       (long)restCountDownNum];
    [self.codeButton setAttributedTitle:[[NSAttributedString alloc] initWithString:title] forState:UIControlStateNormal];
    [self.codeButton setTitleColor:kColor_898989 forState:UIControlStateNormal];
}

- (void)countDownButtonDidEndCountDown:(CountDownButton *)countDownButton {
    
    [self.codeButton setAttributedTitle:[@"Code" addUnderline] forState:UIControlStateNormal];
    [self.codeButton setTitleColor:kBlackColor forState:UIControlStateNormal];
}


- (NSUInteger)startCountDownNumOfCountDownButton:(nonnull CountDownButton *)countDownButton { 
    return  60;
}


@end

NS_ASSUME_NONNULL_END
