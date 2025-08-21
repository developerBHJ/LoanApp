//
//  CustomTabBar.m
//  BilisPera
//
//  Created by BHJ on 2025/8/5.
//

#import "CustomTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomTabBar ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *selectedImages;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, copy) simpleIntCompletion completion;
@property (nonatomic, strong) NSArray *itemViews;

@end
@implementation CustomTabBar

- (instancetype)initWithFrame:(CGRect)frame completion:(simpleIntCompletion)completion
{
    self = [super initWithFrame:frame];
    if (self) {
        self.completion = completion;
        self.defaultIndex = 0;
        [self configUI];
        self.titles = @[@"Home",@"Order",@"Mine"];
        self.images = @[@"icon_home",@"icon_order",@"icon_mine"];
        self.selectedImages = @[@"icon_home_sel",@"icon_order_sel",@"icon_mine_sel"];
        [self addTabBarButtons];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom
            .equalTo(self)
            .inset(kSafeAreaBottomHeight + kRatio(10));
        make.leading.trailing.equalTo(self).inset(kRatio(16));
        make.height.mas_equalTo(kRatio(75));
    }];
    [self addTabBarButtons];
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = kColor_351E29;
        _contentView.layer.cornerRadius = kRatio(75) / 2;
        _contentView.layer.masksToBounds = YES;
        _contentView.layer.shadowColor = [UIColor blackColor].CGColor;
        _contentView.layer.shadowOffset = CGSizeMake(0, 2);
        _contentView.layer.shadowOpacity = 0.3;
        _contentView.layer.shadowRadius = kRatio(8);
        _contentView.clipsToBounds = NO;
    }
    return _contentView;
}

- (void)addTabBarButtons {
    CGFloat buttonWidth = (kScreenW - kRatio(32)) / 3;
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < self.titles.count; i++) {
        BPLayoutButton *button = [BPLayoutButton buttonWithType:UIButtonTypeCustom];
        button.layoutStyle = BPLayoutButtonStyleUpImageDownTitle;
        button.midSpacing = kRatio(4);
        button.frame = CGRectMake(i * buttonWidth,
                                  kRatio(10),
                                  buttonWidth,
                                  kRatio(57));
        button.tag = i;
        [button setImage:kGetImage(self.images[i]) forState:UIControlStateNormal];
        [button setImage:kGetImage(self.selectedImages[i]) forState:UIControlStateSelected];
        [button setImage:kGetImage(self.selectedImages[i]) forState:UIControlStateHighlighted];
        [button setTitle:self.titles[i] forState:UIControlStateNormal];
        [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
        button.titleLabel.font = kFontMedium(14);
        [button addTarget:self action:@selector(tabButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        [tempArray addObject:button];
        if (i == 0) {
            [self updateStyle:button];
        }
    }
    self.itemViews = tempArray;
}

- (void)setDefaultIndex:(NSInteger)defaultIndex{
    _defaultIndex = defaultIndex;
    if (self.itemViews.count > defaultIndex) {
        UIButton *button = self.itemViews[defaultIndex];
        [self updateStyle:button];
    }
}

- (void)tabButtonClicked:(UIButton *)sender {
    if (self.completion) {
        self.completion(sender.tag);
    }
    [self updateStyle:sender];
}

-(void)updateStyle:(UIButton *)sender{
    sender.selected = YES;
    self.selectedButton.selected = NO;
    self.selectedButton = sender;
}

@end

NS_ASSUME_NONNULL_END
