//
//  ProdcutAuthenInputCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import "ProdcutAuthenInputCell.h"

NS_ASSUME_NONNULL_BEGIN
@interface ProdcutAuthenInputCell ()

@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) ProdcutAuthenInputView *inputView;
@property (nonatomic, strong) ProdcutAuthenInputViewModel *model;

@end

@implementation ProdcutAuthenInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRatio(16));
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.contentBgView addSubview:self.inputView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentBgView).offset(kRatio(14));
        make.leading.trailing.equalTo(self.contentBgView).inset(kRatio(12));
        make.bottom.equalTo(self.contentBgView).inset(kRatio(16));
        make.height.mas_greaterThanOrEqualTo(kRatio(84));
    }];
}

-(ProdcutAuthenInputView *)inputView{
    if (!_inputView) {
        _inputView = [[ProdcutAuthenInputView alloc] initWithFrame:CGRectZero];
    }
    return _inputView;
}

- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = [[UIView alloc] init];
        _contentBgView.backgroundColor = kColor_FFDDE8;
        _contentBgView.layer.cornerRadius = kRatio(16);
        _contentBgView.layer.masksToBounds = YES;
        _contentBgView.layer.borderColor = kBlackColor.CGColor;
        _contentBgView.layer.borderWidth = 1.0;
    }
    return _contentBgView;
}

- (void)setModel:(ProdcutAuthenInputViewModel *)model{
    _model = model;
    self.inputView.model = self.model;
}

- (void)configData:(id)data{
    if ([data isKindOfClass:[ProdcutAuthenInputViewModel class]]) {
        self.model = data;
    }
}

@end

NS_ASSUME_NONNULL_END
