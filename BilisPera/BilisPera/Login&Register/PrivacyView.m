//
//  PrivacyView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import "PrivacyView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PrivacyViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tapModel = [[TapLabelModel alloc] init];
    }
    return self;
}

@end

@interface PrivacyView ()

@property (nonatomic, strong) UIButton *checkBox;
@property (nonatomic, strong) TappedLabel *titleLabel;

@end

@implementation PrivacyView

- (instancetype)initWithFrame:(CGRect)frame model:(nonnull PrivacyViewModel *)model;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.model = model;
        [self configUI];
    }
    return self;
}

-(UIButton *)checkBox{
    if (!_checkBox) {
        _checkBox = [[UIButton alloc] init];
        [_checkBox setImage:kGetImage(@"icon_checkBox") forState:UIControlStateNormal];
        [_checkBox setImage:kGetImage(@"icon_checkBox_sel") forState:UIControlStateSelected];
        [_checkBox setImage:kGetImage(@"icon_checkBox_sel") forState:UIControlStateHighlighted];
        [_checkBox addTarget:self action:@selector(checkEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBox;
}

-(TappedLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[TappedLabel alloc] initWithFrame:CGRectZero model:[[TapLabelModel alloc] init]];
    }
    return _titleLabel;
}

-(void)configUI{
    [self addSubview:self.checkBox];
    [self addSubview:self.titleLabel];
    CGFloat imageSize = self.model.isAlert ? kRatio(24) : kRatio(14);
    CGFloat leftSpace = self.model.isAlert ? kRatio(29) : kRatio(18);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.leading.equalTo(self).offset(leftSpace);
        make.trailing.equalTo(self);
    }];
    [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self);
        make.width.height.mas_equalTo(imageSize);
    }];
    self.titleLabel.model = self.model.tapModel;
    
    NSString *imageName = self.model.isAlert ? @"icon_alert_checkBox" : @"icon_checkBox";
    NSString *selectedImageName = self.model.isAlert ? @"icon_alert_checkBox_sel" : @"icon_checkBox_sel";
    [self.checkBox setImage:kGetImage(imageName) forState:UIControlStateNormal];
    [self.checkBox setImage:kGetImage(selectedImageName) forState:UIControlStateSelected];
    [self.checkBox setImage:kGetImage(selectedImageName) forState:UIControlStateHighlighted];
}

-(void)checkEvent:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.model.checkBoxCompletion(sender.selected);
}

@end

NS_ASSUME_NONNULL_END
