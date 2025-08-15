//
//  BPEmptyView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/15.
//

#import "BPEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPEmptyView ()

@property (nonatomic, strong) UIImageView *emptyImageView;
@property (nonatomic, strong) UIButton *refreshButton;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *buttonTitle;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, copy) simpleCompletion completion;

@end

@implementation BPEmptyView

- (instancetype)initWithFrame:(CGRect)frame emptyImage:(NSString *)emptyImage message:(NSString *)message buttonTitle:(NSString *)buttonTitle completion:(simpleCompletion)completion
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageName = emptyImage;
        self.buttonTitle = buttonTitle;
        self.completion = completion;
        self.message = message;
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.emptyImageView];
    [self.emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kRatio(44));
        make.centerX.equalTo(self);
        make.width.mas_equalTo(kRatio(289));
        make.height.mas_equalTo(kRatio(204));
    }];
    
    [self addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emptyImageView.mas_bottom).offset(kRatio(10));
        make.leading.trailing.equalTo(self).inset(kRatio(16));
    }];
    
    [self addSubview:self.refreshButton];
    [self.refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom).offset(kRatio(22));
        make.centerX.equalTo(self);
        make.width.mas_equalTo(kRatio(224));
        make.height.mas_equalTo(kRatio(46));
    }];
    self.emptyImageView.image = kGetImage(self.imageName);
    self.messageLabel.text = self.message;
    [self.refreshButton setTitle:self.buttonTitle forState:UIControlStateNormal];
}

-(void)updateImage:(NSString *)emptyImage message:(NSString *)message buttonTitle:(NSString *)buttonTitle{
    self.imageName = emptyImage;
    self.buttonTitle = buttonTitle;
    self.message = message;
    self.emptyImageView.image = kGetImage(self.imageName);
    self.messageLabel.text = self.message;
    [self.refreshButton setTitle:self.buttonTitle forState:UIControlStateNormal];
    [_refreshButton setHidden:NO];
}

- (UIImageView *)emptyImageView{
    if (!_emptyImageView) {
        _emptyImageView = [[UIImageView alloc] init];
    }
    return _emptyImageView;
}

- (UIButton *)refreshButton{
    if (!_refreshButton) {
        _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _refreshButton.backgroundColor = kColor_351E29;
        _refreshButton.layer.cornerRadius = kRatio(23);
        _refreshButton.layer.masksToBounds = YES;
        [_refreshButton setTitle:@"" forState:UIControlStateNormal];
        [_refreshButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _refreshButton.titleLabel.font = kFontMedium(16);
        [_refreshButton addTarget:self action:@selector(refreshEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_refreshButton setHidden:YES];
    }
    return _refreshButton;
}

-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = kBlackColor;
        _messageLabel.font = kFontMedium(16);
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

-(void)refreshEvent:(UIButton *)sender{
    if (self.completion) {
        self.completion();
    }
}

@end

NS_ASSUME_NONNULL_END
