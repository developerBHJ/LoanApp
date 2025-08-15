//
//  HomeLargeCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "HomeLargeCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation HomeLargeCellModel

- (instancetype)initWith:(NSArray *)items
{
    self = [super init];
    if (self) {
        self.sectionTitle = @"Meet your needs";
        self.items = items;
    }
    return self;
}

@end

@interface HomeLargeCell ()

@property (nonatomic, strong) UILabel *sectionTitleLabel;
@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) HomeLargeCellModel *model;

@end

@implementation HomeLargeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.sectionTitleLabel];
    [self.sectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).inset(kRatio(21));
        make.top.equalTo(self.contentView).offset(kRatio(21));
        make.trailing.equalTo(self.contentView).inset(kRatio(21));
    }];
    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
        make.top.equalTo(self.sectionTitleLabel.mas_bottom).offset(kRatio(10));
        make.bottom.equalTo(self.contentView);
    }];
    [self.contentBgView addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentBgView).inset(kRatio(14));
        make.top.equalTo(self.contentBgView).offset(kRatio(16));
        make.bottom.equalTo(self.contentBgView).inset(kRatio(12));
    }];
}

-(UILabel *)sectionTitleLabel{
    if (!_sectionTitleLabel) {
        _sectionTitleLabel = [[UILabel alloc] init];
        _sectionTitleLabel.textColor = kBlackColor;
        _sectionTitleLabel.font = kFontSemibold(16);
        _sectionTitleLabel.text = @"Common Qs";
    }
    return _sectionTitleLabel;
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_FFE6F2;
        _contentBgView.layer.cornerRadius = kRatio(14);
        _contentBgView.layer.masksToBounds = YES;
    }
    return _contentBgView;
}

- (UIStackView *)stackView{
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.alignment = UIStackViewAlignmentLeading;
        _stackView.spacing = kRatio(16);
    }
    return _stackView;
}

- (void)setModel:(HomeLargeCellModel *)model{
    _model = model;
    if (model.items.count == 0) {
        return;
    }
    [self.stackView removeAllSubViews];
    for (int i = 0; i < model.items.count; i ++) {
        HomeLargeItemViewModel *itemModel = model.items[i];
        HomeLargeItemView *view = [[HomeLargeItemView alloc] initWithFrame:CGRectZero model:itemModel];
        [self.stackView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRatio(52));
            make.width.mas_equalTo((kScreenW - kRatio(60)));
        }];
    }
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[HomeLargeCellModel class]]) {
        self.model = data;
    }
}

@end

NS_ASSUME_NONNULL_END
