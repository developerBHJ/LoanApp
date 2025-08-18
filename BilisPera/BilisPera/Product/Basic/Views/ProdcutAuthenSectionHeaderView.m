//
//  ProdcutAuthenSectionHeaderView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "ProdcutAuthenSectionHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutAuthenSectionHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *leftImageView;

@end

@implementation ProdcutAuthenSectionHeaderView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).inset(kRatio(24));
        make.leading.equalTo(self.contentView).inset(kRatio(26));
        make.trailing.equalTo(self.contentView).inset(kRatio(16));
    }];
    [self.contentView addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.leading.equalTo(self.contentView).inset(kRatio(16));
        make.width.height.mas_equalTo(kRatio(16));
    }];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
    self.leftImageView.image = kGetImage(@"");
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFont(14);
    }
    return _titleLabel;
}

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}


- (void)configData:(id)data{
    if ([data isKindOfClass:[NSString class]]) {
        self.title = data;
    }
}
@end

NS_ASSUME_NONNULL_END
