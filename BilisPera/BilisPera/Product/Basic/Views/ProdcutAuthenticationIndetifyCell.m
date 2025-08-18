//
//  ProdcutAuthenticationIndetifyCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "ProdcutAuthenticationIndetifyCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProdcutAuthenticationIndetifyCellModel

- (instancetype)initWith:(NSString *)title imageUrl:(NSString *)imageUrl image:(UIImage *)image cameraImage:(NSString *)cameraImage exampleModel:(ProdcutAuthenticationExampleViewModel *)exampleModel completion:(simpleCompletion)completion
{
    self = [super init];
    if (self) {
        self.title = title;
        self.imageUrl = imageUrl;
        self.completion = completion;
        self.exampleModel = exampleModel;
        self.image = image;
        self.cameraImage = cameraImage;
    }
    return self;
}

@end

@interface ProdcutAuthenticationIndetifyCell ()

@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *idImageView;
@property (nonatomic, strong) ProdcutAuthenticationExampleView *exampleView;
@property (nonatomic, strong) ProdcutAuthenticationIndetifyCellModel *model;
@property (nonatomic, strong) UIButton *cameraImageView;

@end

@implementation ProdcutAuthenticationIndetifyCell

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
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
        make.top.equalTo(self.contentView).offset(kRatio(20));
        make.bottom.equalTo(self.contentView);
    }];
    [self.contentBgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.contentBgView).inset(kRatio(18));
    }];
    
    [self.contentBgView addSubview:self.idImageView];
    [self.idImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentBgView);
        make.top.equalTo(self.titleLabel.mas_bottom).inset(kRatio(13));
        make.width.mas_equalTo(kRatio(282));
        make.height.mas_equalTo(kRatio(168));
    }];
    
    [self.contentBgView addSubview:self.exampleView];
    [self.exampleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentBgView).inset(kRatio(25));
        make.top.equalTo(self.idImageView.mas_bottom).inset(kRatio(28));
        make.bottom.equalTo(self.contentBgView).inset(kRatio(32));
        make.height.mas_greaterThanOrEqualTo(kRatio(101));
    }];
    
    [self.contentView addSubview:self.cameraImageView];
    [self.cameraImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentBgView).inset(kRatio(30));
        make.top.equalTo(self.titleLabel.mas_bottom).inset(kRatio(13));
        make.height.mas_equalTo(kRatio(168));
    }];
}

- (void)setModel:(ProdcutAuthenticationIndetifyCellModel *)model{
    _model = model;
    self.titleLabel.text = self.model.title;
    if (self.model.image) {
        self.idImageView.image = self.model.image;
    }else{
        [self.idImageView sd_setImageWithURL:[NSURL URLWithString:self.model.imageUrl] placeholderImage:kGetImage(@"icon_auth_identify")];
    }
    CGFloat imageWidth = model.isFace ? kRatio(142) : kRatio(282);
    CGFloat imageHeight = model.isFace ? kRatio(148) : kRatio(168);
    [self.idImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(imageWidth);
        make.height.mas_equalTo(imageHeight);
    }];

    self.exampleView.model = self.model.exampleModel;
    [self.cameraImageView setImage:kGetImage(model.cameraImage) forState:UIControlStateNormal];
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[ProdcutAuthenticationIndetifyCellModel class]]) {
        self.model = data;
    }
}

-(void)tapEvent{
    if (self.model.completion) {
        self.model.completion();
    }
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

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFont(18);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)idImageView{
    if (!_idImageView) {
        _idImageView = [[UIImageView alloc] init];
        _idImageView.layer.cornerRadius = kRatio(10);
        _idImageView.layer.masksToBounds = YES;
    }
    return _idImageView;
}

- (UIButton *)cameraImageView{
    if (!_cameraImageView) {
        _cameraImageView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraImageView setImage:kGetImage(@"icon_auth_camera") forState:UIControlStateNormal];
        _cameraImageView.backgroundColor = [UIColor clearColor];
        [_cameraImageView addTarget:self action:@selector(tapEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraImageView;
}

- (ProdcutAuthenticationExampleView *)exampleView{
    if (!_exampleView) {
        _exampleView = [[ProdcutAuthenticationExampleView alloc] init];
    }
    return _exampleView;
}

@end

NS_ASSUME_NONNULL_END
