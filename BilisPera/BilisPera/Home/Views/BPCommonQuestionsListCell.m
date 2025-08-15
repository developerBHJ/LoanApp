//
//  BPCommonQuestionsListCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "BPCommonQuestionsListCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPCommonQuestionsListCellModel

- (instancetype)initWith:(NSString *)title content:(NSString *)content
{
    self = [super init];
    if (self) {
        self.title = title;
        self.content = content;
    }
    return self;
}

@end

@interface BPCommonQuestionsListCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) BPCommonQuestionsListCellModel *model;

@end

@implementation BPCommonQuestionsListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).inset(kRatio(21));
        make.top.equalTo(self.contentView);
        make.trailing.equalTo(self.contentView).inset(kRatio(21));
    }];
    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kRatio(15));
        make.bottom.equalTo(self.contentView).inset(kRatio(15));
    }];
    
    [self.contentBgView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentBgView).inset(kRatio(12));
        make.top.bottom.equalTo(self.contentBgView).inset(kRatio(14));
    }];
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_FFE6F2;
        _contentBgView.layer.cornerRadius = kRatio(24);
        _contentBgView.layer.masksToBounds = YES;
    }
    return _contentBgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFontMedium(14);
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kColor_444444;
        _contentLabel.font = kFont(14);
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (void)setModel:(BPCommonQuestionsListCellModel *)model{
    _model = model;
    self.titleLabel.text = self.model.title;
    self.contentLabel.text = self.model.content;
}


- (void)configData:(id)data{
    if ([data isKindOfClass:[BPCommonQuestionsListCellModel class]]) {
        self.model = data;
    }
}
@end

NS_ASSUME_NONNULL_END
