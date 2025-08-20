//
//  ProductHomeStepCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/16.
//

#import "ProductHomeStepCell.h"
#import "ProductStepBannerItemView.h"
#import "BPCircleProgressView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProductHomeStepCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Complete The Identity Verification";
    }
    return self;
}

@end

@interface ProductHomeStepCell ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) BPCircleProgressView *progressView;
@property (nonatomic, strong) UIView *progressBgView;
@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) ProductHomeStepCellModel *model;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation ProductHomeStepCell

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
        make.top.equalTo(self.contentView).inset(kRatio(26));
        make.leading.equalTo(self.contentView).inset(kRatio(19));
        make.trailing.equalTo(self.contentView).inset(kRatio(150));
        make.height.mas_greaterThanOrEqualTo(kRatio(80));
    }];
    
    [self.contentView addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).inset(kRatio(5));
        make.trailing.equalTo(self.contentView);
        make.width.height.mas_equalTo(kRatio(160));
    }];

    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).inset(kRatio(39));
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
        make.bottom.equalTo(self.contentView).inset(kRatio(54));
    }];
    
    [self.contentView addSubview:self.progressBgView];
    [self.progressBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).inset(kRatio(13));
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(12));
        make.height.mas_equalTo(kRatio(40));
    }];
    
    [self.progressBgView addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressBgView);
        make.leading.trailing.equalTo(self.progressBgView).inset(kRatio(28));
        make.height.mas_equalTo(kRatio(40));
    }];
    
    [self.contentView addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentBgView.mas_bottom).offset(kRatio(14));
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(kRatio(40));
        make.width.mas_equalTo(kRatio(250));
    }];
    
    [self.contentBgView addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressView.mas_bottom).offset(kRatio(8));
        make.leading.trailing.equalTo(self.contentBgView);
        make.bottom.equalTo(self.contentBgView);
        make.height.mas_equalTo(kRatio(251));
    }];
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_FFDDE8;
        _contentBgView.layer.cornerRadius = kRatio(12);
        _contentBgView.layer.masksToBounds = YES;
    }
    return _contentBgView;
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

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFont(20);
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
    }
    return _rightImageView;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setBackgroundImage:kGetImage(@"icon_product_completed_none") forState:UIControlStateNormal];
        [_nextButton setTitle:@"" forState:UIControlStateNormal];
        [_nextButton setTitleColor:kColor_351E29 forState:UIControlStateNormal];
        _nextButton.titleLabel.font = kFont(14);
        [_nextButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_nextButton setTitleEdgeInsets:UIEdgeInsetsMake(0, kRatio(16), 0, 0)];
    }
    return _nextButton;
}

- (UIView *)progressBgView{
    if (!_progressBgView) {
        _progressBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW - kRatio(24), kRatio(40))];
        _progressBgView.layer.cornerRadius = kRatio(20);
        _progressBgView.layer.masksToBounds = YES;
        _progressBgView.backgroundColor = kColor_FBC4DD;
        _progressBgView.layer.borderColor = kBlackColor.CGColor;
        _progressBgView.layer.borderWidth = 1.0;
    }
    return _progressBgView;
}

- (BPCircleProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[BPCircleProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenW - kRatio(40), kRatio(40))];
    }
    return _progressView;
}

- (void)setModel:(ProductHomeStepCellModel *)model{
    _model = model;
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.model.stepArray.count; i ++) {
        [tempArray addObject:@""];
    }
    self.bannerView.imageURLStringsGroup = tempArray;
    self.titleLabel.text = self.model.title;
    self.rightImageView.image = kGetImage(self.model.imageName);
    [self.nextButton setTitle:self.model.buttonTitle forState:UIControlStateNormal];
    self.progressView.currentStep = self.model.progress;
}


- (void)configData:(id)data{
    if ([data isKindOfClass:[ProductHomeStepCellModel class]]) {
        self.model = data;
    }
}
// MARK: - SDCycleScrollViewDelegate
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view{
    return [ProductStepBannerItemView class];
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view{
    ProductStepBannerItemView *itemView = (ProductStepBannerItemView *)cell;
    ProductStepBannerItemViewModel *itemModel = self.model.stepArray[index];
    itemView.model = itemModel;
}

@end

NS_ASSUME_NONNULL_END
