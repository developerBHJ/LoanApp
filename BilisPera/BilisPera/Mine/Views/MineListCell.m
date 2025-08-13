//
//  MineListCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import "MineListCell.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MineListCellModel

- (instancetype)initWith:(MineListType)type
{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (NSString *)title{
    NSString *name = @"";
    switch (self.type) {
        case BPMineListOnlineService:
            name = @"Online Service";
            break;
        case BPMineListPrivacy:
            name = @"Privacy Agreement";
            break;
        case BPMineListSetting:
            name = @"Settings";
            break;
        case BPMineListVersion:
            name = @"Version";
            break;
        case BPMineListLogOut:
            name = @"Log out";
            break;
    }
    return name;
}

- (NSString *)imageName{
    NSString *name = @"";
    switch (self.type) {
        case BPMineListOnlineService:
            name = @"icon_mine_onlineservice";
            break;
        case BPMineListPrivacy:
            name = @"icon_mine_privacy";
            break;
        case BPMineListSetting:
            name = @"icon_mine_setting";
            break;
        default:
            name = @"";
            break;
    }
    return name;
}

- (NSString *)content{
    NSString *name = @"";
    switch (self.type) {
        case BPMineListVersion:
            name = [NSString stringWithFormat:@"%@%@",@"v ",kAppVersion];
            break;
        default:
            name = @"";
            break;
    }
    return name;
}

@end

@interface MineListCell ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MineListCell

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
    }];
    [self.backView addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).inset(kRatio(13));
        make.bottom.equalTo(self.backView.mas_bottom).inset(kRatio(13));
        make.leading.equalTo(self.backView.mas_leading).inset(kRatio(13));
        make.width.height.mas_equalTo(kRatio(32));
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
            .equalTo(self.leftImageView.mas_trailing)
            .offset(kRatio(10));
        make.trailing
            .equalTo(self.arrowImageView.mas_leading)
            .offset(-kRatio(10));
    }];
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = kColor_FFDDE8;
        _backView.layer.cornerRadius = kRatio(16);
        _backView.layer.masksToBounds = YES;
        _backView.layer.borderColor = kBlackColor.CGColor;
        _backView.layer.borderWidth = 1.0;
    }
    return _backView;
}

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = kGetImage(@"icon_arrow_right");
    }
    return _arrowImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.font = kFontMedium(16);
    }
    return _titleLabel;
}

- (void)setModel:(MineListCellModel *)model{
    _model = model;
    self.titleLabel.text = self.model.title;
    self.leftImageView.image = kGetImage(self.model.imageName);
}

@end

NS_ASSUME_NONNULL_END
