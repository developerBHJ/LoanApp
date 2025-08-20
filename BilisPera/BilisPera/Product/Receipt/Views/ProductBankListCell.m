//
//  ProductBankListCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import "ProductBankListCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProductBankListCellModel

- (instancetype)initWith:(NSArray<ProdcutAuthenInputViewModel *> *)items
{
    self = [super init];
    if (self) {
        self.items = items;
    }
    return self;
}

@end

@interface ProductBankListCell ()

@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) ProductBankListCellModel *model;

@end

@implementation ProductBankListCell

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
        make.top.equalTo(self.contentView).offset(kRatio(16));
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.contentBgView addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentBgView).offset(kRatio(16));
        make.leading.trailing.equalTo(self.contentBgView).inset(kRatio(12));
        make.bottom.equalTo(self.contentBgView).inset(kRatio(26));
        make.height.mas_greaterThanOrEqualTo(kRatio(84));
    }];
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

- (UIStackView *)stackView{
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.alignment = UIStackViewAlignmentFill;
        _stackView.spacing = kRatio(24);
    }
    return _stackView;
}

- (void)setModel:(ProductBankListCellModel *)model{
    _model = model;
    [self.stackView removeAllSubViews];
    for (ProdcutAuthenInputViewModel *item in model.items) {
        ProdcutAuthenInputView *itemView = [[ProdcutAuthenInputView alloc] initWithFrame:CGRectZero];
        itemView.model = item;
        [self.stackView addArrangedSubview:itemView];
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenW - kRatio(44));
            make.height.mas_equalTo(kRatio(70));
        }];
    }
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[ProductBankListCellModel class]]) {
        self.model = data;
    }
}

@end

NS_ASSUME_NONNULL_END
