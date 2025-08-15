//
//  BPCommonQuestionsHeaderView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "BPCommonQuestionsHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPCommonQuestionsHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation BPCommonQuestionsHeaderView

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
    [self addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.trailing.equalTo(self).inset(kRatio(16));
        make.bottom.equalTo(self).offset(kRatio(8));
        make.width.height.mas_equalTo(117);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).inset(kRatio(29));
        make.leading.equalTo(self).inset(kRatio(18));
        make.trailing.equalTo(self).inset(kRatio(130));
    }];
    
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).inset(kRatio(10));
        make.leading.equalTo(self).inset(kRatio(18));
        make.trailing.equalTo(self).inset(kRatio(130));
    }];
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kColor_B43E64;
        _titleLabel.font = kFontMedium(18);
        _titleLabel.text = @"Common sense question";
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kColor_494949;
        _contentLabel.font = kFont(12);
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"Intimate service, accompany you around";
    }
    return _contentLabel;
}

- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = kGetImage(@"icon_question");
    }
    return _rightImageView;
}
@end

NS_ASSUME_NONNULL_END
