//
//  ProductStepBannerItemView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/16.
//

#import "ProductStepBannerItemView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProductStepBannerItemViewModel

- (instancetype)initWith:(BPProductStep)step finished:(BOOL)finished completion:(simpleIntCompletion)completion
{
    self = [super init];
    if (self) {
        self.step = step;
        self.finished = finished;
        self.completion = self.completion;
    }
    return self;
}

- (NSString *)title{
    NSString *name = @"";
    switch (self.step) {
        case BPProductStepFaceId:
            name = @"Verify Identity";
            break;
        case BPProductStepBasic:
            name = @"Personal Information";
            break;
        case BPProductStepWork:
            name = @"Work Information";
            break;
        case BPProductStepContact:
            name = @"Contact Information";
            break;
        case BPProductStepBank:
            name = @"Bank Card Info";
            break;
    }
    return name;
}

- (NSString *)content{
    NSString *name = @"";
    switch (self.step) {
        case BPProductStepFaceId:
            name = @"Photo ID is only used for real nameauthen tication";
            break;
        case BPProductStepBasic:
            name = @"Information will never beprovided tooutside parties";
            break;
        case BPProductStepWork:
            name = @"Multiple safeguards to keep your funds safe";
            break;
        case BPProductStepContact:
            name = @"Advanced encryption technology to protect your privacy";
            break;
        case BPProductStepBank:
            name = @"You need to fill in your bankcard information for verification";
            break;
    }
    return name;
}


- (NSString *)imageName{
    NSString *name = @"";
    switch (self.step) {
        case BPProductStepFaceId:
            name = @"icon_product_faceId";
            break;
        case BPProductStepBasic:
            name = @"icon_product_personal";
            break;
        case BPProductStepWork:
            name = @"icon_product_work";
            break;
        case BPProductStepContact:
            name = @"icon_product_contact";
            break;
        case BPProductStepBank:
            name = @"icon_product_bank";
            break;
    }
    return name;
}

- (NSString *)selectedImageName{
    NSString *name = @"";
    switch (self.step) {
        case BPProductStepFaceId:
            name = @"icon_product_faceId_sel";
            break;
        case BPProductStepBasic:
            name = @"icon_product_personal_sel";
            break;
        case BPProductStepWork:
            name = @"icon_product_work_sel";
            break;
        case BPProductStepContact:
            name = @"icon_product_contact_sel";
            break;
        case BPProductStepBank:
            name = @"icon_product_bank_sel";
            break;
    }
    return name;
}


@end

@interface ProductStepBannerItemView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *statusBgView;
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation ProductStepBannerItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRatio(32));
        make.leading.equalTo(self.contentView).offset(kRatio(19));
        make.trailing.equalTo(self.contentView).offset(-kRatio(140));
    }];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(4));
        make.leading.equalTo(self.titleLabel);
        make.trailing.equalTo(self.contentView).offset(-kRatio(140));
    }];
    
    [self.contentView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kRatio(8));
        make.trailing.equalTo(self);
        make.width.height.mas_equalTo(kRatio(133));
        make.bottom.equalTo(self).inset(kRatio(102));
    }];
    
    [self.contentView addSubview:self.statusBgView];
    [self.statusBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(kRatio(250));
        make.height.mas_equalTo(kRatio(40));
        make.bottom.equalTo(self.contentView).inset(kRatio(19));
    }];
    
    [self.statusBgView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.statusBgView).offset(kRatio(22));
        make.centerY.equalTo(self.statusBgView);
    }];
    
    [self setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
    [self addGestureRecognizer:tapGR];
}

-(void)tapEvent{
    if (self.model.completion) {
        self.model.completion(self.model.step);
    }
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kColor_351E29;
        _titleLabel.font = kFont(18);
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kColor_333333;
        _contentLabel.font = kFontMedium(14);
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UIImageView *)statusBgView{
    if (!_statusBgView) {
        _statusBgView = [[UIImageView alloc] init];
        _statusBgView.image = kGetImage(@"icon_product_completed");
    }
    [_statusBgView setHidden:YES];
    return _statusBgView;
}

- (UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = kWhiteColor;
        _statusLabel.font = kFont(16);
        _statusLabel.text = @"Completed";
    }
    [_statusLabel setHidden:YES];
    return _statusLabel;
}

- (void)setModel:(ProductStepBannerItemViewModel *)model{
    _model = model;
    self.titleLabel.text = self.model.title;
    self.contentLabel.text = self.model.content;
    NSString *imageName = self.model.finished ? self.model.selectedImageName : self.model.imageName;
    self.iconView.image = kGetImage(imageName);
    [self.statusLabel setHidden:!self.model.finished];
    [self.statusBgView setHidden:!self.model.finished];
}

@end

NS_ASSUME_NONNULL_END
