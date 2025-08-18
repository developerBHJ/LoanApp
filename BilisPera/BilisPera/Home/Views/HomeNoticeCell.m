//
//  HomeNoticeCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "HomeNoticeCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation HomeNoticeCellModel

- (instancetype)initWith:(NSString *)title completion:(nullable simpleCompletion)completion
{
    self = [super init];
    if (self) {
        self.title = title;
        self.completion = completion;
    }
    return self;
}

@end

@interface HomeNoticeCell ()

@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIButton *arrowView;

@end

@implementation HomeNoticeCell

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
    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.contentBgView addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.equalTo(self.contentBgView);
        make.width.height.mas_equalTo(kRatio(74));
    }];
    
    [self.contentBgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.leftImageView.mas_trailing).inset(kRatio(12));
        make.top.bottom.equalTo(self.contentBgView).inset(kRatio(16));
        make.trailing
            .equalTo(self.contentBgView.mas_trailing)
            .offset(-kRatio(56));
    }];
    
    [self.contentBgView addSubview:self.arrowView];
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentBgView).inset(kRatio(15));
        make.bottom.equalTo(self.contentBgView).offset(-kRatio(10));
        make.width.mas_equalTo(kRatio(38));
        make.height.mas_equalTo(kRatio(20));
    }];
    [self.contentBgView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
    [self.contentBgView addGestureRecognizer:tapGR];
}

-(void)tapEvent{
    if (self.model.completion) {
        self.model.completion();
    }
}

- (void)setModel:(HomeNoticeCellModel *)model{
    _model = model;
    self.titleLabel.text = self.model.title;
}


- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_FBE7F2;
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
        _titleLabel.textColor = kColor_351E29;
        _titleLabel.font = kFontMedium(14);
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = kGetImage(@"icon_home_notice");
    }
    return _leftImageView;
}

- (UIButton *)arrowView{
    if (!_arrowView) {
        _arrowView = [UIButton buttonWithType:UIButtonTypeCustom];
        _arrowView.backgroundColor = kBlackColor;
        _arrowView.layer.cornerRadius = kRatio(10);
        _arrowView.layer.masksToBounds = YES;
        [_arrowView setImage:[kGetImage(@"iocn_arrow_black") imageWithTintColor:kWhiteColor] forState:UIControlStateNormal];
    }
    return _arrowView;
}

@end

NS_ASSUME_NONNULL_END
