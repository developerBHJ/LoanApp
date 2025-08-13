//
//  MineOrderCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import "MineOrderCell.h"
#import "BPLayoutButton.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MineOrderCellModel

- (instancetype)initWith:(BPOrderStatus)status itemClick:(BPOrderItemCompletion)itemClick
{
    self = [super init];
    if (self) {
        self.status = status;
        self.itemClick = itemClick;
    }
    return self;
}

- (NSString *)title{
    NSString *name = @"";
    switch (self.status) {
        case BPOrderStatusAll:
            name = @"Order";
            break;
        case BPOrderStatusApplying:
            name = @"Applying";
            break;
        case BPOrderStatusRepayment:
            name = @"Repayment";
            break;
        case BPOrderStatusFinish:
            name = @"Finish";
            break;
    }
    return name;
}

- (NSString *)imageName{
    NSString *imageName = @"";
    switch (self.status) {
        case BPOrderStatusAll:
            imageName = @"icon_mine_order";
            break;
        case BPOrderStatusApplying:
            imageName = @"icon_mine_applying";
            break;
        case BPOrderStatusRepayment:
            imageName = @"icon_mine_repayment";
            break;
        case BPOrderStatusFinish:
            imageName = @"icon_mine_finish";
            break;
    }
    return imageName;
}
@end

@interface MineOrderCell ()
@property (nonatomic, strong) UIStackView *stackView;
@end

@implementation MineOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (UIStackView *)stackView{
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.alignment = UIStackViewAlignmentLeading;
        _stackView.spacing = 0;
        _stackView.backgroundColor = kColor_FFDDE8;
        _stackView.layer.cornerRadius = kRatio(14);
        _stackView.layer.masksToBounds = YES;
        _stackView.layer.borderColor = kBlackColor.CGColor;
        _stackView.layer.borderWidth = 1.0;
    }
    return _stackView;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
    }];
}

- (void)setItems:(NSArray<MineOrderCellModel *> *)items{
    _items = items;
    if (items.count == 0) {
        return;
    }
    [self.stackView removeAllSubViews];
    for (int i = 0; i < items.count; i ++) {
        MineOrderCellModel *model = items[i];
        BPLayoutButton *itemButton = [[BPLayoutButton alloc] init];
        [itemButton setTitle:model.title forState:UIControlStateNormal];
        [itemButton setImage:kGetImage(model.imageName) forState:UIControlStateNormal];
        [itemButton setTitleColor:kBlackColor forState:UIControlStateNormal];
        itemButton.titleLabel.font = kFont(14);
        itemButton.layoutStyle = BPLayoutButtonStyleUpImageDownTitle;
        itemButton.midSpacing = kRatio(7);
        itemButton.imageSize = CGSizeMake(kRatio(40), kRatio(40));
        itemButton.tag = 1000 + i;
        [itemButton addTarget:self action:@selector(itemClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.stackView addArrangedSubview:itemButton];
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRatio(102));
            make.width.mas_equalTo((kScreenW - kRatio(32)) / 4);
        }];
    }
}

-(void)itemClickEvent:(UIButton *)sender{
    NSInteger index = sender.tag - 1000;
    if (self.items.count > index) {
        MineOrderCellModel *model = self.items[index];
        model.itemClick(model.status);
    }
}

@end

NS_ASSUME_NONNULL_END
