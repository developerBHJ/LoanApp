//
//  OrderListSegementView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "OrderListSegementView.h"
#import "BPLayoutButton.h"

NS_ASSUME_NONNULL_BEGIN
@implementation OrderListSegementViewItemModel

- (instancetype)initWith:(BPOrderStatus)status completion:(simpleIntCompletion)completion
{
    self = [super init];
    if (self) {
        self.status = status;
        self.completion = completion;
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

- (NSString *)selectedImageName{
    NSString *imageName = @"";
    switch (self.status) {
        case BPOrderStatusAll:
            imageName = @"icon_order_all";
            break;
        case BPOrderStatusApplying:
            imageName = @"icon_order_aplying";
            break;
        case BPOrderStatusRepayment:
            imageName = @"icon_order_repayment";
            break;
        case BPOrderStatusFinish:
            imageName = @"icon_order_finish";
            break;
    }
    return imageName;
}

- (NSString *)imageName{
    NSString *imageName = @"";
    switch (self.status) {
        case BPOrderStatusAll:
            imageName = @"icon_order_all_sel";
            break;
        case BPOrderStatusApplying:
            imageName = @"icon_order_applying_sel";
            break;
        case BPOrderStatusRepayment:
            imageName = @"icon_order_repayment_sel";
            break;
        case BPOrderStatusFinish:
            imageName = @"icon_order_finish_sel";
            break;
    }
    return imageName;
}

- (CGFloat)itemWidth{
    return [self.title getWidthWithFont:kFont(14) height:kRatio(20)] + kRatio(16) + kRatio(18);
}

@end


@interface OrderListSegementView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) NSMutableArray<UIButton *>* itemViews;

@end


@implementation OrderListSegementView

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<OrderListSegementViewItemModel *> *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = items;
        self.defaultIndex = 0;
        self.itemViews = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.equalTo(self);
        make.width.mas_equalTo(kScreenW - kRatio(32));
        make.height.mas_equalTo(kRatio(42));
    }];
}

- (void)setItems:(NSArray<OrderListSegementViewItemModel *> *)items{
    _items = items;
    [self configItems];
}

- (void)configItems{
    if (self.items.count == 0) {
        return;
    }
    CGFloat maxWidth = kScreenW - kRatio(32);
    CGFloat totalWidth = 0;
    self.itemViews = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.items.count; i ++) {
        OrderListSegementViewItemModel *itemModel = self.items[i];
        BPLayoutButton *view = [BPLayoutButton buttonWithType:UIButtonTypeCustom];
        view.frame = CGRectMake(totalWidth,
                                kRatio(10),
                                itemModel.itemWidth,
                                kRatio(32));
        view.layoutStyle = BPLayoutButtonStyleLeftImageRightTitle;
        view.midSpacing = kRatio(2);
        [view setTitle:itemModel.title forState:UIControlStateNormal];
        [view setTitleColor:kColor_351E29 forState:UIControlStateNormal];
        [view setTitleColor:kWhiteColor forState:UIControlStateSelected];
        [view setTitleColor:kWhiteColor forState:UIControlStateHighlighted];
        [view setImage:kGetImage(itemModel.imageName) forState:UIControlStateNormal];
        [view setImage:kGetImage(itemModel.selectedImageName) forState:UIControlStateSelected];
        [view setImage:kGetImage(itemModel.selectedImageName) forState:UIControlStateHighlighted];
        [view addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        view.backgroundColor = [UIColor colorWithHex:0x351E29 alpha:0.2];
        view.layer.borderColor = kBlackColor.CGColor;
        view.layer.borderWidth = 1.0;
        view.layer.cornerRadius = kRatio(16);
        view.layer.masksToBounds = true;
        view.tag = i + 1000;
        [self.scrollView addSubview:view];
        [self.itemViews addObject:view];
        totalWidth += itemModel.itemWidth;
        if (i != (self.items.count - 1)) {
            totalWidth += kRatio(7);
        }
    }
    self.scrollView.contentSize = CGSizeMake(totalWidth, 0);
    [self.scrollView setScrollEnabled:totalWidth > maxWidth];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (void)setDefaultIndex:(NSInteger)defaultIndex{
    _defaultIndex = defaultIndex;
    if (self.itemViews.count > defaultIndex) {
        UIButton *btn = self.itemViews[defaultIndex];
        [self updateSelectedStyle:btn];
    }
}


-(void)itemClick:(UIButton *)sender{
    if (self.selectedButton == sender) {
        return;
    }
    [self updateSelectedStyle:sender];
    NSInteger index = sender.tag - 1000;
    OrderListSegementViewItemModel *model = self.items[index];
    if (model.completion) {
        model.completion(model.status);
    }
}

-(void)updateSelectedStyle:(UIButton *)sender{
    sender.selected = YES;
    sender.backgroundColor = kBlackColor;
    self.selectedButton.selected = NO;
    self.selectedButton.backgroundColor = [UIColor colorWithHex:0x351E29 alpha:0.2];
    self.selectedButton = sender;
    CGFloat visibleX = sender.center.x - self.bounds.size.width/2;
    visibleX = MAX(0,
                   MIN(visibleX,
                       self.scrollView.contentSize.width - self.bounds.size.width));
    if (sender.tag == 1000) {
        visibleX = 0;
    }
    [self.scrollView setContentOffset:CGPointMake(visibleX, 0) animated:YES];
}

@end

NS_ASSUME_NONNULL_END
