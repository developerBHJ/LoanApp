//
//  HomeNoticeBannerCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/16.
//

#import "HomeNoticeBannerCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation HomeNoticeBannerCellModel


@end

@interface HomeNoticeBannerCell ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) HomeNoticeBannerCellModel *model;

@end

@implementation HomeNoticeBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
        make.top.equalTo(self.contentView).offset(kRatio(12));
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(kRatio(74));
    }];
}


- (SDCycleScrollView *)bannerView{
    if (!_bannerView) {
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _bannerView.pageDotColor = [kColor_351E29 colorWithAlphaComponent:0.2];
        _bannerView.currentPageDotColor = kColor_351E29;
        _bannerView.pageControlDotSize = CGSizeMake(kRatio(8), kRatio(8));
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.pageControlBottomOffset = kRatio(78);
        _bannerView.autoScrollTimeInterval = 5.0;
    }
    return _bannerView;
}

- (void)setModel:(HomeNoticeBannerCellModel *)model{
    _model = model;
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.model.items.count; i ++) {
        [tempArray addObject:@""];
    }
    self.bannerView.imageURLStringsGroup = tempArray;
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[HomeNoticeBannerCellModel class]]) {
        self.model = data;
    }
}

// MARK: - SDCycleScrollViewDelegate
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view{
    return [HomeNoticeCell class];
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
    HomeNoticeCell *itemView = (HomeNoticeCell *)cell;
    HomeNoticeCellModel *itemModel = self.model.items[index];
    itemView.model = itemModel;
}

@end

NS_ASSUME_NONNULL_END
