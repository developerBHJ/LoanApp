//
//  BPProductAuthenResultView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import "BPProductAuthenResultView.h"

NS_ASSUME_NONNULL_BEGIN
@implementation BPProductAuthenResultViewModel

@end

@interface BPProductAuthenResultView ()

@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *successImageView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation BPProductAuthenResultView

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
    [self addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self);
        make.leading.trailing.equalTo(self);
    }];
    
    [self.contentBgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentBgView).inset(kRatio(60));
        make.leading.equalTo(self.contentBgView).inset(kRatio(22));
        make.trailing.equalTo(self.contentBgView).inset(kRatio(130));
    }];
    
    [self.contentBgView addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentBgView);
        make.trailing.equalTo(self.contentBgView);
        make.width.height.mas_equalTo(kRatio(127));
    }];
    
    [self.contentBgView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(10));
        make.leading.equalTo(self.contentBgView).inset(kRatio(22));
        make.trailing.equalTo(self.contentBgView).inset(kRatio(90));
    }];
    
    [self.contentBgView addSubview:self.successImageView];
    [self.successImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(kRatio(25));
        make.centerX.equalTo(self.contentBgView);
        make.width.mas_equalTo(kRatio(240));
        make.height.mas_equalTo(kRatio(65));
    }];
    
    [self.contentBgView addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.successImageView.mas_bottom).offset(kRatio(20));
        make.leading.trailing.equalTo(self.contentBgView).inset(kRatio(22));
    }];
    
    [self.contentBgView addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stackView.mas_bottom).offset(kRatio(36));
        make.leading.trailing.equalTo(self.contentBgView).inset(kRatio(60));
        make.height.mas_equalTo(kRatio(44));
        make.bottom.equalTo(self.contentBgView).inset(kRatio(46));
    }];
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_FFDDE8;
        _contentBgView.layer.cornerRadius = kRatio(24);
        _contentBgView.layer.masksToBounds = YES;
        _contentBgView.layer.borderColor = kBlackColor.CGColor;
        _contentBgView.layer.borderWidth = 1.0;
    }
    return _contentBgView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kColor_351E29;
        _titleLabel.font = kFont(16);
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = kColor_777777;
        _subTitleLabel.font = kFont(12);
        _subTitleLabel.numberOfLines = 0;
    }
    return _subTitleLabel;
}

- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
    }
    return _rightImageView;
}

- (UIImageView *)successImageView{
    if (!_successImageView) {
        _successImageView = [[UIImageView alloc] init];
    }
    return _successImageView;
}

- (UIStackView *)stackView{
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = kRatio(25);
    }
    return _stackView;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.backgroundColor = kColor_351E29;
        _nextButton.layer.cornerRadius = kRatio(22);
        _nextButton.layer.masksToBounds = YES;
        [_nextButton setTitle:@"Confirm" forState:UIControlStateNormal];
        [_nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _nextButton.titleLabel.font = kFont(18);
        [_nextButton addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

-(void)nextStep{
    if (self.model.completion) {
        self.model.completion();
    }
}

- (void)setModel:(BPProductAuthenResultViewModel *)model{
    _model = model;
    self.titleLabel.text = self.model.title;
    self.subTitleLabel.text = self.model.subTitle;
    self.rightImageView.image = kGetImage(self.model.rightImageName);
    self.successImageView.image = kGetImage(self.model.imageName);
    [self.stackView removeAllSubViews];
    for (int i = 0; i < model.items.count; i ++) {
        BPProductAuthenResultItemViewModel *itemModel = model.items[i];
        BPProductAuthenResultItemView *view = [[BPProductAuthenResultItemView alloc] initWithFrame:CGRectZero];
        view.model = itemModel;
        [self.stackView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRatio(48));
            make.width.mas_equalTo((kScreenW - kRatio(76)));
        }];
    }
}
@end

NS_ASSUME_NONNULL_END
