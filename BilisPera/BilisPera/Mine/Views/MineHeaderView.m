//
//  MineHeaderView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import "MineHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineHeaderView ()

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MineHeaderView

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
    [self addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kRatio(20));
        make.leading.equalTo(self).offset(kRatio(24));
        make.width.mas_equalTo(kRatio(58));
        make.height.mas_equalTo(kRatio(58));
        make.bottom.equalTo(self).offset(-kRatio(15));
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView.mas_top).offset(kRatio(5));
        make.leading.equalTo(self.avatarView.mas_trailing).offset(kRatio(14));
        make.trailing.equalTo(self.mas_trailing).offset(-kRatio(120));
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(5));
        make.leading.equalTo(self.titleLabel);
        make.trailing.equalTo(self.titleLabel);
    }];
}

- (UIImageView *)avatarView{
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] init];
        _avatarView.image = kGetImage(@"icon_avatar");
        _avatarView.layer.cornerRadius = kRatio(20);
        _avatarView.layer.masksToBounds = YES;
    }
    return _avatarView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFontMedium(20);
        _titleLabel.text = @"Hi ! ";
    }
    return _titleLabel;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = kBlackColor;
        _nameLabel.font = kFontMedium(16);
    }
    return _nameLabel;
}

- (void)setNickName:(NSString *)nickName{
    self.nameLabel.text = nickName;
}

@end

NS_ASSUME_NONNULL_END
