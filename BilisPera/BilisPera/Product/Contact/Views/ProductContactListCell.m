//
//  ProductContactListCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import "ProductContactListCell.h"

NS_ASSUME_NONNULL_BEGIN
@implementation ProductContactListCellModel

- (instancetype)initWithTitle:(NSString *)title relationModel:(ProdcutAuthenInputViewModel *)relationModel numberModel:(ProdcutAuthenInputViewModel *)numberModel
{
    self = [super init];
    if (self) {
        self.title = title;
        self.relationModel = relationModel;
        self.numberModel = numberModel;
    }
    return self;
}

@end

@interface ProductContactListCell ()

@property (nonatomic, strong) ProductContactListCellModel *model;
@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) ProdcutAuthenInputView *relationView;
@property (nonatomic, strong) ProdcutAuthenInputView *numberView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ProductContactListCell

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
        make.top.equalTo(self.contentView).offset(kRatio(26));
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(22));
    }];
    
    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(10));
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.contentBgView addSubview:self.relationView];
    [self.relationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentBgView).offset(kRatio(14));
        make.leading.trailing.equalTo(self.contentBgView).inset(kRatio(12));
        make.height.mas_greaterThanOrEqualTo(kRatio(70));
    }];
    
    [self.contentBgView addSubview:self.numberView];
    [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.relationView.mas_bottom).offset(kRatio(25));
        make.leading.trailing.equalTo(self.contentBgView).inset(kRatio(12));
        make.bottom.equalTo(self.contentBgView).inset(kRatio(23));
        make.height.mas_greaterThanOrEqualTo(kRatio(70));
    }];
}

-(ProdcutAuthenInputView *)relationView{
    if (!_relationView) {
        _relationView = [[ProdcutAuthenInputView alloc] initWithFrame:CGRectZero];
    }
    return _relationView;
}

-(ProdcutAuthenInputView *)numberView{
    if (!_numberView) {
        _numberView = [[ProdcutAuthenInputView alloc] initWithFrame:CGRectZero];
    }
    return _numberView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFontMedium(16);
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_FFDDE8;
        _contentBgView.layer.cornerRadius = kRatio(16);
        _contentBgView.layer.masksToBounds = YES;
        _contentBgView.layer.borderColor = kBlackColor.CGColor;
        _contentBgView.layer.borderWidth = 1.0;
    }
    return _contentBgView;
}

- (void)setModel:(ProductContactListCellModel *)model{
    _model = model;
    self.titleLabel.text = self.model.title;
    self.relationView.model = self.model.relationModel;
    self.numberView.model = self.model.numberModel;
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[ProductContactListCellModel class]]) {
        self.model = data;
    }
}

@end


NS_ASSUME_NONNULL_END
