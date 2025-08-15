//
//  HomeKingKongItemView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/13.
//

#import "HomeKingKongItemView.h"

NS_ASSUME_NONNULL_BEGIN
@interface HomeKingKongItemView ()

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end


@implementation HomeKingKongItemView

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
    [self addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(kRatio(76));
    }];
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kRatio(32));
        make.leading.trailing.bottom.equalTo(self);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).offset(kRatio(6));
        make.leading.trailing.equalTo(self.bgView).inset(kRatio(12));
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(6));
        make.leading.trailing.equalTo(self.bgView).inset(kRatio(10));
        make.bottom.equalTo(self.bgView).inset(kRatio(15));
    }];
    [self bringSubviewToFront:self.topImageView];
    [self.contentLabel setContentHuggingPriority:UILayoutConstraintAxisVertical forAxis:UILayoutPriorityDefaultHigh];
    [self setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
    [self addGestureRecognizer:tapGR];
}

- (void)setModel:(HomeKingKongItemViewModel *)model{
    _model = model;
    self.topImageView.image = kGetImage(self.model.imageName);
    self.titleLabel.text = self.model.title;
    self.contentLabel.text = self.model.subTitle;
    self.bgView.backgroundColor = self.model.backColor;
}

-(void)tapEvent{
    if (self.model.completion) {
        self.model.completion(self.model.type);
    }
}

- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
    }
    return _topImageView;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.layer.cornerRadius = kRatio(20);
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFont(12);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kColor_333333;
        _contentLabel.font = kFont(10);
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

@end

NS_ASSUME_NONNULL_END
