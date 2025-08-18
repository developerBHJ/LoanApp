//
//  ProdcutAuthenticationUserInfoCell.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "ProdcutAuthenticationUserInfoCell.h"

NS_ASSUME_NONNULL_BEGIN
@interface ProdcutAuthenticationUserInfoCell ()

@property (nonatomic, strong) ProdcutAuthenInputView *inputView;
@property (nonatomic, strong) ProdcutAuthenInputViewModel *model;

@end

@implementation ProdcutAuthenticationUserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.inputView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRatio(14));
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(16));
        make.bottom.equalTo(self.contentView);
        make.height.mas_greaterThanOrEqualTo(kRatio(81));
    }];
}

-(ProdcutAuthenInputView *)inputView{
    if (!_inputView) {
        _inputView = [[ProdcutAuthenInputView alloc] initWithFrame:CGRectZero];
    }
    return _inputView;
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
