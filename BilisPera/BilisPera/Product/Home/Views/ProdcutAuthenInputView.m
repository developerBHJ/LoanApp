//
//  ProdcutAuthenInputView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "ProdcutAuthenInputView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProdcutAuthenInputViewModel

- (instancetype)initWith:(BPProductFormStyle)style title:(NSString *)title text:(NSString *)text placeHolder:(NSString *)placeHolder inputBgColor:(UIColor *)inputBgColor completion:(simpleCompletion)completion valueChanged:(simpleStringCompletion)valueChanged
{
    self = [super init];
    if (self) {
        self.style = style;
        self.title = title;
        self.text = text;
        self.placeHolder = placeHolder;
        self.inputBgColor = inputBgColor;
        self.completion = completion;
        self.valueChanged = valueChanged;
    }
    return self;
}

- (NSString *)rightImageName{
    NSString *image = @"";
    switch (self.style) {
        case BPProductFormStyleText:
            image = @"icon_auth_edit";
            break;
        case BPProductFormStyleEnum:
            image = @"iocn_arrow_black";
            break;
        case BPProductFormStyleSelected:
            image = @"iocn_arrow_black";
            break;
    }
    return image;
}

@end

@interface ProdcutAuthenInputView ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *rightView;
@property (nonatomic, strong) UIButton *tapButton;

@end

@implementation ProdcutAuthenInputView

- (instancetype)initWithFrame:(CGRect)frame model:(ProdcutAuthenInputViewModel *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        self.model = model;
        [self configUI];
    }
    return self;
}

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
        make.top.equalTo(self);
        make.leading.equalTo(self);
        make.trailing.equalTo(self).inset(kRatio(10));
    }];
    [self addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(5));
        make.leading.bottom.trailing.equalTo(self);
    }];
    
    [self.contentBgView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentBgView);
        make.leading.equalTo(self.contentBgView).inset(kRatio(10));
        make.trailing.equalTo(self.contentBgView).inset(kRatio(30));
    }];
    
    [self.contentBgView addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentBgView);
        make.trailing.equalTo(self.contentBgView).inset(kRatio(18));
        make.width.height.mas_equalTo(kRatio(16));
    }];
    
    [self.contentBgView addSubview:self.tapButton];
    [self.tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentBgView);
        make.top.bottom.equalTo(self.contentBgView);
        make.height.mas_greaterThanOrEqualTo(kRatio(47));
    }];
}

- (void)setModel:(ProdcutAuthenInputViewModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.textField.text = model.text;
    self.textField.placeholder = model.placeHolder;
    self.contentBgView.backgroundColor = self.model.inputBgColor;
    self.rightView.image = kGetImage(self.model.rightImageName);
    [self.tapButton setHidden:self.model.style == BPProductFormStyleText];
}

-(void)tapEvent{
    if (self.model.completion) {
        self.model.completion();
    }
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_FFDDE8;
        _contentBgView.layer.cornerRadius = kRatio(10);
        _contentBgView.layer.masksToBounds = YES;
        _contentBgView.layer.borderColor = kBlackColor.CGColor;
        _contentBgView.layer.borderWidth = 1.0;
    }
    return _contentBgView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFont(14);
    }
    return _titleLabel;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textColor = kBlackColor;
        _textField.font = kFont(14);
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UIImageView *)rightView{
    if (!_rightView) {
        _rightView = [[UIImageView alloc] init];
    }
    return _rightView;
}

- (UIButton *)tapButton{
    if (!_tapButton) {
        _tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _tapButton.backgroundColor = [UIColor clearColor];
        [_tapButton addTarget:self action:@selector(tapEvent) forControlEvents:UIControlEventTouchUpInside];
        [_tapButton setHidden:YES];
    }
    return _tapButton;
}

-(void)textValueChanged:(UITextField *)textField{
    if (self.model.valueChanged) {
        self.model.valueChanged(textField.text ?: @"");
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

}
@end

NS_ASSUME_NONNULL_END
