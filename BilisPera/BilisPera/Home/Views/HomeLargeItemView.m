//
//  HomeLargeItemView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "HomeLargeItemView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation HomeLargeItemViewModel

- (instancetype)initWith:(NSString *)title imageName:(NSString *)imageName completion:(nullable simpleCompletion)completion
{
    self = [super init];
    if (self) {
        self.title = title;
        self.ImageName = imageName;
        self.completion = completion;
    }
    return self;
}

@end

@interface HomeLargeItemView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightImageView;

@end


@implementation HomeLargeItemView

- (instancetype)initWithFrame:(CGRect)frame model:(HomeLargeItemViewModel *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        self.model = model;
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = kWhiteColor;
    self.layer.cornerRadius = kRatio(52) / 2;
    self.layer.masksToBounds = YES;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.leading.equalTo(self).inset(kRatio(16));
        make.trailing.equalTo(self).inset(kRatio(40));
    }];
    [self addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self).inset(kRatio(5));
        make.width.height.mas_equalTo(40);
    }];
    [self setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
    [self addGestureRecognizer:tapGR];
}

-(void)tapEvent{
    if (self.model.completion) {
        self.model.completion();
    }
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFontMedium(14);
    }
    return _titleLabel;
}

- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
    }
    return _rightImageView;
}

- (void)setModel:(HomeLargeItemViewModel *)model{
    _model = model;
    self.titleLabel.text = self.model.title;
    self.rightImageView.image = kGetImage(self.model.ImageName);
}

@end

NS_ASSUME_NONNULL_END
