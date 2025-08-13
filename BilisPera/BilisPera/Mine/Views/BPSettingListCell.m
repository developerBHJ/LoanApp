//
//  BPSettingListCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import "BPSettingListCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPSettingListCell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation BPSettingListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).inset(kRatio(20));
        make.leading.equalTo(self.contentView.mas_leading).inset(kRatio(16));
        make.trailing.equalTo(self.contentView.mas_trailing).inset(kRatio(16));
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(kRatio(64));
    }];
    
    [self.backView addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView.mas_centerY);
        make.trailing.equalTo(self.backView.mas_trailing).inset(kRatio(14));
        make.width.height.mas_equalTo(kRatio(18));
    }];
    
    [self.backView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top);
        make.bottom.equalTo(self.backView.mas_bottom);
        make.leading
            .equalTo(self.backView.mas_leading)
            .offset(kRatio(25));
        make.trailing
            .equalTo(self.backView.mas_centerX)
            .offset(-kRatio(10));
    }];
    
    [self.backView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top);
        make.bottom.equalTo(self.backView.mas_bottom);
        make.leading
            .equalTo(self.backView.mas_centerX)
            .offset(kRatio(10));
        make.trailing
            .equalTo(self.backView.mas_trailing)
            .offset(-kRatio(20));
    }];
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = kColor_FFDDE8;
        _backView.layer.cornerRadius = kRatio(32);
        _backView.layer.masksToBounds = YES;
        _backView.layer.borderColor = kBlackColor.CGColor;
        _backView.layer.borderWidth = 1.0;
    }
    return _backView;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = kGetImage(@"icon_arrow_right");
        [_arrowImageView setHidden:YES];
    }
    return _arrowImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFontBold(16);
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kBlackColor;
        _contentLabel.font = kFont(14);
        _contentLabel.textAlignment = NSTextAlignmentRight;
        [_contentLabel setHidden:YES];
    }
    return _contentLabel;
}

- (void)setModel:(MineListCellModel *)model{
    _model = model;
    self.titleLabel.text = self.model.title;
    self.contentLabel.text = self.model.content;
    [self.contentLabel setHidden:self.model.content.length == 0];
    [self.arrowImageView setHidden:self.model.content.length > 0];
}

@end

NS_ASSUME_NONNULL_END
