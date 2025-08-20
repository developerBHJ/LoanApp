//
//  BPProductAuthenResultItemView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import "BPProductAuthenResultItemView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPProductAuthenResultItemViewModel

- (instancetype)init:(NSString *)title content:(NSString *)content
{
    self = [super init];
    if (self) {
        self.title = title;
        self.content = content;
    }
    return self;
}

@end

@interface BPProductAuthenResultItemView ()

@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation BPProductAuthenResultItemView

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
    [self addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.leading.trailing.equalTo(self);
    }];
    
    [self.contentBgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.leading.equalTo(self.contentBgView).inset(kRatio(13));
        make.trailing.equalTo(self.contentBgView.mas_centerX);
    }];
    
    [self.contentBgView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.leading.equalTo(self.contentBgView.mas_centerX);
        make.trailing.equalTo(self.contentBgView).inset(kRatio(13));
    }];
}


- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_FFDDE8;
        _contentBgView.layer.cornerRadius = kRatio(14);
        _contentBgView.layer.masksToBounds = YES;
        _contentBgView.layer.borderColor = kBlackColor.CGColor;
        _contentBgView.layer.borderWidth = 1.0;
    }
    return _contentBgView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFont(14);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kBlackColor;
        _contentLabel.font = kFont(14);
        _contentLabel.textAlignment = NSTextAlignmentRight;
    }
    return _contentLabel;
}

- (void)setModel:(BPProductAuthenResultItemViewModel *)model{
    _model = model;
    self.titleLabel.text = self.model.title;
    self.contentLabel.text = self.model.content;
}
@end

NS_ASSUME_NONNULL_END
