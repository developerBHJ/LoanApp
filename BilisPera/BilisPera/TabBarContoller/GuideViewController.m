//
//  GuideViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/8.
//

#import "GuideViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GuideViewController ()

@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *subTitleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIButton *nextButton;

@end

@implementation GuideViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self configUI];
}


- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.image = kGetImage(@"icon_guide_bg");
    }
    return _topImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFont(26);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return  _titleLabel;
}

- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = kBlackColor;
        _subTitleLabel.font = kFont(14);
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return  _subTitleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kColor_848176;
        _contentLabel.font = kFont(14);
        _contentLabel.numberOfLines = 0;
    }
    return  _contentLabel;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [[UIButton alloc] init];
        [_nextButton setTitle:@"" forState:UIControlStateNormal];
        [_nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _nextButton.titleLabel.font = kFont(22);
        _nextButton.backgroundColor = kColor_351E29;
        _nextButton.layer.cornerRadius = kRatio(50) / 2;
        _nextButton.layer.masksToBounds = true;
        [_nextButton addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

-(void)nextEvent{
    kUserDefaultSet(@YES, isFirstLuanch);
    [[Routes shared] changeRootView];
}

-(void)configUI{
    [self.view addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.top.equalTo(self.view.mas_top);
        make.height.mas_equalTo(kRatio(350));
    }];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).offset(kRatio(10));
        make.trailing.equalTo(self.view.mas_trailing).offset(-kRatio(10));
        make.top.equalTo(self.topImageView.mas_bottom).offset(kRatio(45));
    }];
    
    [self.view addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).offset(kRatio(10));
        make.trailing.equalTo(self.view.mas_trailing).offset(-kRatio(10));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(15));
    }];
    
    [self.view addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading).offset(kRatio(10));
        make.trailing.equalTo(self.view.mas_trailing).offset(-kRatio(10));
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(kRatio(34));
        make.height.mas_greaterThanOrEqualTo(kRatio(70));
    }];
    
    [self.view addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(kRatio(73));
        make.width.mas_equalTo(kRatio(222));
        make.height.mas_equalTo(kRatio(50));
    }];
    
    _titleLabel.text = [LocalizationManager stringForModule:@"Common" key:@"guide_title" defaultText:@""];
    _subTitleLabel.text = [LocalizationManager stringForModule:@"Common" key:@"guide_subTitle" defaultText:@""];
    _contentLabel.text = [LocalizationManager stringForModule:@"Common" key:@"guide_content" defaultText:@""];
    NSString *buttonTitle =  [LocalizationManager stringForModule:@"Common" key:@"guide_nextButton_title" defaultText:@""];
    [_nextButton setTitle:buttonTitle forState:UIControlStateNormal];
}

@end

NS_ASSUME_NONNULL_END
