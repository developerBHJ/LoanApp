//
//  HomeCommonQuestionsCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/13.
//

#import "HomeCommonQuestionsCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation HomeCommonQuestionsCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sectionTitle = @"Common sense question";
        self.title = @"Common sense question";
        self.subTitle = @"Intimate service, accompany you around";
    }
    return self;
}

@end


@interface HomeCommonQuestionsCell ()

@property (nonatomic, strong) UILabel *sectionTitleLabel;
@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIButton *arrowView;
@property (nonatomic, strong) HomeCommonQuestionsCellModel *model;

@end

@implementation HomeCommonQuestionsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.sectionTitleLabel];
    [self.sectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).inset(kRatio(21));
        make.top.equalTo(self.contentView).offset(kRatio(26));
        make.trailing.equalTo(self.contentView).inset(kRatio(21));
    }];
    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
        make.top.equalTo(self.sectionTitleLabel.mas_bottom).offset(kRatio(10));
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.contentView).inset(kRatio(29));
        make.top.equalTo(self.sectionTitleLabel.mas_centerY);
        make.width.height.mas_equalTo(kRatio(88));
    }];
    
    [self.contentBgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentBgView).inset(kRatio(14));
        make.top.equalTo(self.contentBgView).inset(kRatio(7));
        make.trailing
            .equalTo(self.rightImageView.mas_leading)
            .offset(-kRatio(10));
    }];
    
    [self.contentBgView addSubview:self.subTitleLabel];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentBgView).inset(kRatio(14));
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.trailing
            .equalTo(self.rightImageView.mas_leading)
            .offset(-kRatio(10));
    }];
    
    [self.contentBgView addSubview:self.arrowView];
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentBgView).inset(kRatio(14));
        make.top.equalTo(self.subTitleLabel.mas_bottom).offset(kRatio(4));
        make.bottom.equalTo(self.contentBgView).offset(-kRatio(6));
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

-(UILabel *)sectionTitleLabel{
    if (!_sectionTitleLabel) {
        _sectionTitleLabel = [[UILabel alloc] init];
        _sectionTitleLabel.textColor = kBlackColor;
        _sectionTitleLabel.font = kFontSemibold(16);
        _sectionTitleLabel.text = @"Common Qs";
    }
    return _sectionTitleLabel;
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_FFE6F2;
        _contentBgView.layer.cornerRadius = kRatio(14);
        _contentBgView.layer.masksToBounds = YES;
    }
    return _contentBgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFontMedium(16);
        _titleLabel.text = @"Common sense question";
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = kColor_494949;
        _subTitleLabel.font = kFont(12);
        _subTitleLabel.text = @"Intimate service, accompany you around";
        _subTitleLabel.numberOfLines = 0;
    }
    return _subTitleLabel;
}

- (UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = kGetImage(@"icon_home_questions");
    }
    return _rightImageView;
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


- (void)setModel:(HomeCommonQuestionsCellModel *)model{
    _model = model;
    self.sectionTitleLabel.text = self.model.sectionTitle;
    self.titleLabel.text = self.model.title;
    self.subTitleLabel.text = self.model.subTitle;
}


- (void)configData:(id)data{
    if ([data isKindOfClass:[HomeCommonQuestionsCellModel class]]) {
        self.model = data;
    }
}

@end

NS_ASSUME_NONNULL_END
