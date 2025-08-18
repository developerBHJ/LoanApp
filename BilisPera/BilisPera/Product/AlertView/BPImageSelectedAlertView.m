//
//  BPImageSelectedAlertView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "BPImageSelectedAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPImageSelectedAlertViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.leftImage = @"icon_product_camera";
        self.rightImage = @"icon_product_library";
    }
    return self;
}

@end

@interface BPImageSelectedAlertView ()

@property (nonatomic, strong) UIButton *photoImageView;
@property (nonatomic, strong) UIButton *cameraImageView;
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation BPImageSelectedAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame model:[[BPImageSelectedAlertViewModel alloc] init]];
}

- (instancetype)initWithFrame:(CGRect)frame model:(BPImageSelectedAlertViewModel *)model {
    self = [super initWithFrame:frame];
    if (self) {
        _model = model;
        [self setupUI];
        [self applyModel];
    }
    return self;
}

- (UIButton *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [UIButton buttonWithType:UIButtonTypeCustom];
        _photoImageView.backgroundColor = [UIColor whiteColor];
        [_photoImageView setImage:[UIImage imageNamed:@"icon_product_library"] forState:UIControlStateNormal];
        [_photoImageView addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        _photoImageView.tag = 1001;
        _photoImageView.layer.cornerRadius = kRatio(20);
        _photoImageView.layer.masksToBounds = YES;
    }
    return _photoImageView;
}

- (UIButton *)cameraImageView {
    if (!_cameraImageView) {
        _cameraImageView = [UIButton buttonWithType:UIButtonTypeCustom];
        _cameraImageView.backgroundColor = [UIColor whiteColor];
        [_cameraImageView setImage:[UIImage imageNamed:@"icon_product_camera"] forState:UIControlStateNormal];
        [_cameraImageView addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        _cameraImageView.tag = 1000;
        _cameraImageView.layer.cornerRadius = kRatio(20);
        _cameraImageView.layer.masksToBounds = YES;
    }
    return _cameraImageView;
}

- (void)setModel:(BPImageSelectedAlertViewModel *)model {
    _model = model;
    [self applyModel];
}

- (void)setupUI {
    [self addSubview:self.photoImageView];
    [self addSubview:self.cameraImageView];
    
    [self.cameraImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.leading.equalTo(self).offset(kRatio(20));
        make.width.mas_equalTo(kRatio(164));
        make.height.mas_equalTo(kRatio(203));
        make.bottom.equalTo(self);
    }];
    
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.trailing.equalTo(self).offset(-kRatio(20));
        make.width.mas_equalTo(kRatio(164));
        make.height.mas_equalTo(kRatio(203));
        make.bottom.equalTo(self);
    }];
}

- (void)applyModel {
    [self.cameraImageView setImage:[UIImage imageNamed:self.model.leftImage] forState:UIControlStateNormal];
    [self.photoImageView setImage:[UIImage imageNamed:self.model.rightImage] forState:UIControlStateNormal];
}

- (void)buttonEvent:(UIButton *)sender {
    if (self.model.selectedCompletion) {
        self.model.selectedCompletion(sender.tag - 1000);
    }
    self.selectedButton.layer.borderColor = [UIColor clearColor].CGColor;
    self.selectedButton.layer.borderWidth = 0;
    sender.layer.borderColor = kBlackColor.CGColor;
    sender.layer.borderWidth = 1;
    self.selectedButton = sender;
}


@end

NS_ASSUME_NONNULL_END
