//
//  ProductBankSegementCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import "ProductBankSegementCell.h"

NS_ASSUME_NONNULL_BEGIN
@implementation ProductBankSegementCellModel

- (instancetype)initWith:(NSArray<NSString *> *)titles values:(NSArray<NSNumber *> *)values completion:(simpleIntCompletion)completion
{
    self = [super init];
    if (self) {
        self.titles = titles;
        self.values = values;
        self.completion = completion;
    }
    return self;
}

@end

@interface ProductBankSegementCell ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) ProductBankSegementCellModel *model;
@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation ProductBankSegementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRatio(24));
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(kRatio(36));
        make.width.mas_greaterThanOrEqualTo(kRatio(200));
    }];
}

- (UIStackView *)stackView{
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.alignment = UIStackViewAlignmentCenter;
        _stackView.spacing = kRatio(40);
    }
    return _stackView;
}

- (void)setModel:(ProductBankSegementCellModel *)model{
    _model = model;
    [self.stackView removeAllSubViews];
    for (int i = 0; i < model.titles.count; i ++) {
        NSString *title = model.titles[i];
        NSNumber *num = model.values[i];
        UIButton *itemView = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemView setTitle:title forState:UIControlStateNormal];
        [itemView setTitleColor:kBlackColor forState:UIControlStateNormal];
        itemView.backgroundColor = kColor_FFDDE8;
        itemView.layer.cornerRadius = kRatio(6);
        itemView.layer.masksToBounds = YES;
        itemView.titleLabel.font = kFontMedium(14);
        [self.stackView addArrangedSubview:itemView];
        CGFloat itemWidth = [title getWidthWithFont:kFontMedium(14) height:kRatio(25)] + kRatio(40);
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(itemWidth);
            make.height.mas_equalTo(kRatio(36));
        }];
        itemView.tag = 1000 + num.integerValue;
        [itemView addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        if (self.model.defaultType == num.integerValue) {
            [self updateButton:itemView];
        }
    }
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[ProductBankSegementCellModel class]]) {
        self.model = data;
    }
}

-(void)buttonEvent:(UIButton *)sender{
    if (self.selectedButton == sender) {
        return;
    }
    [self updateButton:sender];
    NSInteger value = sender.tag - 1000;
    if (self.model.completion) {
        self.model.completion(value);
    }
}

-(void)updateButton:(UIButton *)sender{
    sender.backgroundColor = kColor_351E29;
    [sender setTitleColor:kWhiteColor forState:UIControlStateNormal];
    self.selectedButton.backgroundColor = kColor_FFDDE8;
    [self.selectedButton setTitleColor:kColor_351E29 forState:UIControlStateNormal];
    self.selectedButton = sender;
}

@end

NS_ASSUME_NONNULL_END
