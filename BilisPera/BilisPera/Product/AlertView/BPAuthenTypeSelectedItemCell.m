//
//  BPAuthenTypeSelectedItemCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import "BPAuthenTypeSelectedItemCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPAuthenTypeSelectedItemCellModel

- (instancetype)initWith:(NSString *)title imageUrl:(NSString *)imageUrl isSelected:(BOOL)isSelected
{
    self = [super init];
    if (self) {
        self.title = title;
        self.imageUrl = imageUrl;
        self.selected = isSelected;
    }
    return self;
}


@end

@interface BPAuthenTypeSelectedItemCell ()

@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) BPAuthenTypeSelectedItemCellModel *model;

@end

@implementation BPAuthenTypeSelectedItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView);
        make.bottom.top.equalTo(self.contentView).inset(kRatio(10));
        make.height.mas_greaterThanOrEqualTo(kRatio(50));
    }];
    
    [self.contentBgView addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentBgView).inset(kRatio(30));
        make.centerY.top.equalTo(self.contentBgView);
        make.width.height.mas_equalTo(kRatio(26));
    }];
    
    [self.contentBgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentBgView).inset(kRatio(64));
        make.top.bottom.trailing.top.equalTo(self.contentBgView);
    }];
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[BPAuthenTypeSelectedItemCellModel class]]) {
        self.model = data;
    }
}

- (void)setModel:(BPAuthenTypeSelectedItemCellModel *)model{
    _model = model;
    self.titleLabel.text = self.model.title;
    CGFloat leftSpace = self.model.imageUrl.length > 0 ? kRatio(64) : kRatio(30);
    UIColor *backColor = self.model.selected ? kColor_FFF6F9 : [UIColor clearColor];
    self.contentBgView.backgroundColor = backColor;
    [self.leftImageView setHidden:self.model.imageUrl.length == 0];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentBgView).inset(leftSpace);
    }];
    if (self.model.imageUrl.length > 0) {
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl]];
    }
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.layer.cornerRadius = kRatio(10);
        _contentBgView.layer.masksToBounds = YES;
    }
    return _contentBgView;
}

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFont(14);
    }
    return _titleLabel;
}

@end

NS_ASSUME_NONNULL_END
