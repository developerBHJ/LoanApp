//
//  HomeKingKongCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/13.
//

#import "HomeKingKongCell.h"
#import "HomeKingKongItemView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation HomeKingKongItemViewModel

- (instancetype)initWith:(HomeKingKongType)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (NSString *)title{
    NSString *name = @"";
    switch (self.type) {
        case HomeKingKongTypeOrder:
            name = @"Order";
            break;
        case HomeKingKongTypeResponse:
            name = @"Response";
            break;
        case HomeKingKongTypeService:
            name = @" Service";
            break;
    }
    return name;
}

- (NSString *)subTitle{
    NSString *name = @"";
    switch (self.type) {
        case HomeKingKongTypeOrder:
            name = @"Apply for a loan anytime, anywhere";
            break;
        case HomeKingKongTypeResponse:
            name = @"Easily solve your daily problems";
            break;
        case HomeKingKongTypeService:
            name = @"3 minutes to apply for funding";
            break;
    }
    return name;
}

- (NSString *)imageName{
    NSString *name = @"";
    switch (self.type) {
        case HomeKingKongTypeOrder:
            name = @"icon_home_order";
            break;
        case HomeKingKongTypeResponse:
            name = @"icon_home_response";
            break;
        case HomeKingKongTypeService:
            name = @"icon_home_service";
            break;
    }
    return name;
}

- (UIColor *)backColor{
    UIColor *bgColor = [UIColor clearColor];
    switch (self.type) {
        case HomeKingKongTypeOrder:
            bgColor = [UIColor colorWithHex:0xFFDFEE];
            break;
        case HomeKingKongTypeResponse:
            bgColor = [UIColor colorWithHex:0xD7F6FF];
            break;
        case HomeKingKongTypeService:
            bgColor = [UIColor colorWithHex:0xDCFFAC];
            break;
    }
    return bgColor;
}

@end

@implementation HomeKingKongCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = [[NSArray alloc] init];
    }
    return self;
}

@end

@interface HomeKingKongCell ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) HomeKingKongCellModel *model;

@end

@implementation HomeKingKongCell

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
        make.top.bottom.equalTo(self.contentView);
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
    }];
}

- (UIStackView *)stackView{
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.alignment = UIStackViewAlignmentLeading;
        _stackView.spacing = kRatio(7);
    }
    return _stackView;
}

- (void)setModel:(HomeKingKongCellModel *)model{
    _model = model;
    if (model.items.count == 0) {
        return;
    }
    [self.stackView removeAllSubViews];
    for (int i = 0; i < model.items.count; i ++) {
        HomeKingKongItemViewModel *itemModel = model.items[i];
        HomeKingKongItemView *view = [[HomeKingKongItemView alloc] initWithFrame:CGRectZero];
        view.model = itemModel;
        [self.stackView addArrangedSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kRatio(155));
            make.width.mas_equalTo((kScreenW - kRatio(46)) / 3);
        }];
    }
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[HomeKingKongCellModel class]]) {
        self.model = data;
    }
}


@end

NS_ASSUME_NONNULL_END
