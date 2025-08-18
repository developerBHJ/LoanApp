//
//  ProdcutAuthenticationItemView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import "ProdcutAuthenticationItemView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProdcutAuthenticationItemViewModel

- (instancetype)initWith:(NSString *)title needLine:(BOOL)needLine completion:(simpleStringCompletion)completion
{
    self = [super init];
    if (self) {
        self.title = title;
        self.needLine = needLine;
        self.completion = completion;
    }
    return self;
}

@end

@interface ProdcutAuthenticationItemView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ProdcutAuthenticationItemView

- (instancetype)initWithFrame:(CGRect)frame model:(ProdcutAuthenticationItemViewModel *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        self.model = model;
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self).inset(kRatio(1));
        make.leading.equalTo(self).inset(kRatio(16));
        make.trailing.equalTo(self).inset(kRatio(60));
    }];
    
    [self addSubview:self.arrowView];
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self).inset(kRatio(16));
        make.width.height.mas_equalTo(kRatio(16));
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.leading.trailing.equalTo(self).inset(kRatio(9));
        make.height.mas_equalTo(kRatio(1));
    }];
    [self addTapEvent:@selector(tapEvent)];
}

-(void)tapEvent{
    if (self.model.completion) {
        self.model.completion(self.model.title);
    }
}

- (void)setModel:(ProdcutAuthenticationItemViewModel *)model{
    _model = model;
    self.titleLabel.text = self.model.title;
    [self.lineView setHidden: !self.model.needLine];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFont(14);
    }
    return _titleLabel;
}

- (UIImageView *)arrowView{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] init];
        _arrowView.image = kGetImage(@"icon_arrow_right");
    }
    return _arrowView;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHex:0x4C3A43 alpha:0.6];
    }
    return _lineView;
}

@end

NS_ASSUME_NONNULL_END
