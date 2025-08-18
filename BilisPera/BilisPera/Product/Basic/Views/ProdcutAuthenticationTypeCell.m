//
//  ProdcutAuthenticationTypeCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import "ProdcutAuthenticationTypeCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProdcutAuthenticationTypeCellModel

- (instancetype)initWith:(NSString *)title items:(NSArray *)items
{
    self = [super init];
    if (self) {
        self.sectionTitle = title;
        self.items = items;
    }
    return self;
}

@end

@interface ProdcutAuthenticationTypeCell ()

@property (nonatomic, strong) ProdcutAuthenticationTypeCellModel *model;
@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UILabel *titleLabel;


@end


@implementation ProdcutAuthenticationTypeCell

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
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
        make.top.equalTo(self.contentView).offset(kRatio(14));
        make.bottom.equalTo(self.contentView);
    }];
    [self.contentBgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.contentBgView).inset(kRatio(16));
    }];
    
    [self.contentBgView addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(9));
        make.leading.trailing.equalTo(self.contentBgView);
        make.bottom.equalTo(self.contentBgView).offset(-kRatio(10));
    }];
}

- (void)setModel:(ProdcutAuthenticationTypeCellModel *)model{
    _model = model;
    self.titleLabel.text = self.model.sectionTitle;
    [self.stackView removeAllSubViews];
    for (int i = 0; i < model.items.count; i ++) {
        ProdcutAuthenticationItemViewModel *itemModel = model.items[i];
        ProdcutAuthenticationItemView *view = [[ProdcutAuthenticationItemView alloc] initWithFrame:CGRectZero model:itemModel];
        [self.stackView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRatio(45));
            make.width.mas_equalTo((kScreenW - kRatio(32)));
        }];
    }
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[ProdcutAuthenticationTypeCellModel class]]) {
        self.model = data;
    }
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_FFDDE8;
        _contentBgView.layer.cornerRadius = kRatio(20);
        _contentBgView.layer.masksToBounds = YES;
        _contentBgView.layer.borderColor = kBlackColor.CGColor;
        _contentBgView.layer.borderWidth = 1.0;
    }
    return _contentBgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFontMedium(16);
    }
    return _titleLabel;
}

- (UIStackView *)stackView{
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.spacing = 0;
    }
    return _stackView;
}

@end

NS_ASSUME_NONNULL_END
