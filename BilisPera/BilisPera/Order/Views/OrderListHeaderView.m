//
//  OrderListHeaderView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "OrderListHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderListHeaderView ()

@property (nonatomic, strong) OrderListSegementView *segementView;
@property (nonatomic, strong) UIImageView *topImageView;

@end

@implementation OrderListHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame items:(nonnull NSArray<OrderListSegementViewItemModel *> *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = items;
        [self configUI];
    }
    return self;
}

- (void)setItems:(NSArray<OrderListSegementViewItemModel *> *)items{
    _items = items;
    self.segementView.items = items;
    self.segementView.defaultIndex = 0;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.leading.trailing.equalTo(self).inset(kRatio(16));
        make.height.mas_equalTo(kRatio(79));
    }];
    
    [self addSubview:self.segementView];
    [self.segementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom);
        make.leading.trailing.equalTo(self).inset(kRatio(16));
        make.height.mas_equalTo(kRatio(42));
        make.bottom.equalTo(self);
    }];
}

- (OrderListSegementView *)segementView{
    if (!_segementView) {
        _segementView = [[OrderListSegementView alloc] initWithFrame:CGRectZero items:self.items];
    }
    return _segementView;
}

- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.image = kGetImage(@"icon_order_header_bg");
    }
    return _topImageView;
}

@end

NS_ASSUME_NONNULL_END
