//
//  BPAlertHeasderView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "BPAlertHeasderView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPAlertHeasderViewModel

- (instancetype)initWith:(NSString *)title needClose:(BOOL)needClose completion:(simpleCompletion)completion
{
    self = [super init];
    if (self) {
        self.title = title;
        self.completion = completion;
        self.needClose = needClose;
    }
    return self;
}

@end

@interface BPAlertHeasderView ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation BPAlertHeasderView

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
    [self addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(kRatio(220));
        make.height.mas_equalTo(kRatio(52));
    }];

    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self).inset(kRatio(14));
        make.centerX.equalTo(self);
    }];
    [self addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).inset(kRatio(20));
        make.centerY.equalTo(self.titleLabel);
        make.width.height.mas_equalTo(24);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kWhiteColor;
        _titleLabel.font = kFont(18);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.layer.cornerRadius = kRatio(12);
        [_closeButton setImage:kGetImage(@"icon_close") forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = kGetImage(@"icon_alert_title_bg");
    }
    return _backImageView;
}

-(void)closeEvent{
    if (self.model.completion) {
        self.model.completion();
    }
}

- (void)setModel:(BPAlertHeasderViewModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    [self.closeButton setHidden: !model.needClose];
}

@end

NS_ASSUME_NONNULL_END
