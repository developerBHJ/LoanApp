//
//  ProdcutAuthenticationExampleView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "ProdcutAuthenticationExampleView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProdcutAuthenticationExampleViewModel

- (instancetype)initWith:(NSString *)title items:(NSArray<NSString *> *)items
{
    self = [super init];
    if (self) {
        self.title = title;
        self.items = items;
    }
    return self;
}

@end

@interface ProdcutAuthenticationExampleView ()

@property (nonatomic, strong) UILabel *exampleTitle;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation ProdcutAuthenticationExampleView

- (instancetype)initWithFrame:(CGRect)frame model:(ProdcutAuthenticationExampleViewModel *)model
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
    [self addSubview:self.exampleTitle];
    [self.exampleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
    }];
    
    [self addSubview:self.leftView];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.exampleTitle);
        make.trailing.equalTo(self.exampleTitle.mas_leading).inset(kRatio(16));
        make.width.mas_equalTo(kRatio(32));
        make.height.mas_equalTo(kRatio(1));
    }];
    
    [self addSubview:self.rightView];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.exampleTitle);
        make.leading.equalTo(self.exampleTitle.mas_trailing).inset(kRatio(16));
        make.width.mas_equalTo(kRatio(32));
        make.height.mas_equalTo(kRatio(1));
    }];
    
    [self addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.exampleTitle.mas_bottom).offset(kRatio(24));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.width.mas_greaterThanOrEqualTo(kScreenW - kRatio(100));
        make.height.mas_greaterThanOrEqualTo(kRatio(55));
    }];
}

- (void)setModel:(ProdcutAuthenticationExampleViewModel *)model{
    _model = model;
    self.exampleTitle.text = model.title;
    [self.stackView removeAllSubViews];
    for (int i = 0; i < model.items.count; i ++) {
        NSString *imageName = model.items[i];
        UIImageView *view = [[UIImageView alloc] init];
        view.image = kGetImage(imageName);
        [self.stackView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRatio(55));
            make.width.mas_equalTo(kRatio(45));
        }];
    }
}

- (UIStackView *)stackView{
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.spacing = kRatio(30);
    }
    return _stackView;
}

- (UILabel *)exampleTitle{
    if (!_exampleTitle) {
        _exampleTitle = [[UILabel alloc] init];
        _exampleTitle.textColor = kBlackColor;
        _exampleTitle.font = kFont(16);
        _exampleTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _exampleTitle;
}

- (UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = kBlackColor;
    }
    return _leftView;
}

- (UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc] init];
        _rightView.backgroundColor = kBlackColor;
    }
    return _rightView;
}
@end

NS_ASSUME_NONNULL_END
