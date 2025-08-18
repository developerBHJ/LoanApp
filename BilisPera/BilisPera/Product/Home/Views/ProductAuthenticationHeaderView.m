//
//  ProductAuthenticationHeaderView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "ProductAuthenticationHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProductAuthenticationHeaderViewModel

- (instancetype)initWith:(NSString *)title subTitle:(NSString *)subTitle imageName:(NSString *)imageName
{
    self = [super init];
    if (self) {
        self.title = title;
        self.subTitle = subTitle;
        self.imageName = imageName;
    }
    return self;
}

@end

@interface ProductAuthenticationHeaderView ()

@property (nonatomic, strong) ProductAuthenticationHeaderViewModel *model;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *stepImageView;

@end

@implementation ProductAuthenticationHeaderView

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRatio(24));
        make.leading.equalTo(self.contentView).offset(kRatio(16));
        make.trailing.equalTo(self.contentView).offset(-kRatio(160));
    }];
    
    [self.contentView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(8));
        make.leading.equalTo(self.contentView).offset(kRatio(16));
        make.trailing.equalTo(self.contentView).offset(-kRatio(120));
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.stepImageView];
    [self.stepImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRatio(16));
        make.trailing.equalTo(self.contentView).offset(-kRatio(30));
        make.width.height.mas_equalTo(kRatio(82));
    }];
}

- (void)setModel:(ProductAuthenticationHeaderViewModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
    self.stepImageView.image = kGetImage(model.imageName);
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[ProductAuthenticationHeaderViewModel class]]) {
        self.model = data;
    }
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFont(20);
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = kBlackColor;
        _subTitleLabel.font = kFontMedium(12);
        _subTitleLabel.numberOfLines = 0;
    }
    return _subTitleLabel;
}

- (UIImageView *)stepImageView{
    if (!_stepImageView) {
        _stepImageView = [[UIImageView alloc] init];
    }
    return _stepImageView;
}

@end

NS_ASSUME_NONNULL_END
