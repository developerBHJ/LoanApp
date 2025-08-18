//
//  BPProductAuthInfoConfirmViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "BPProductAuthInfoConfirmViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPProductAuthInfoConfirmViewController ()<UITableViewDelegate,UITableViewDataSource,BPProductAuthInfoConfirmViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) BPProductAuthInfoConfirmViewModel *viewModel;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) ProductAuthenIndetyInfoModel *model;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation BPProductAuthInfoConfirmViewController


- (instancetype)initWith:(ProductAuthenIndetyInfoModel *)model productId:(NSString *)productId{
    if (self = [super init]) {
        self.model = model;
        self.productId = productId;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self configViewModel];
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)configUI{
    self.backButton.frame = self.view.bounds;
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.leading.trailing.equalTo(self.view).inset(kRatio(12));
    }];
    
    [self.contentView addSubview:self.whiteView];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView).inset(kRatio(13));
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(10));
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).inset(kRatio(29));
        make.leading.equalTo(self.contentView).inset(kRatio(16));
        make.trailing.equalTo(self.contentView).inset(kRatio(60));
    }];
    
    [self.contentView addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.trailing.equalTo(self.contentView).inset(kRatio(25));
        make.width.height.mas_equalTo(kRatio(28));
    }];
    
    [self.contentView addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).inset(kRatio(46));
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(kRatio(198));
        make.height.mas_equalTo(kRatio(42));
    }];
    
    [self.contentView addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.nextButton.mas_top).inset(kRatio(20));
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(10));
    }];
    
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kRatio(72));
        make.leading.trailing.equalTo(self.contentView).inset(kRatio(6));
        make.bottom
            .equalTo(self.tipsLabel.mas_top)
            .inset(kRatio(20));
        make.height.mas_greaterThanOrEqualTo(kRatio(300));
    }];
}

-(void)configViewModel{
    self.viewModel = [[BPProductAuthInfoConfirmViewModel alloc] init];
    self.viewModel.infoModel = self.model;
    [self.viewModel reloadData];
    self.viewModel.delegate = self;
    [self.tableView registerClass:[ProdcutAuthenticationUserInfoCell class] forCellReuseIdentifier:[[ProdcutAuthenticationUserInfoCell alloc] init].reuseId];
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = kColor_FFDDE8;
        _contentView.layer.cornerRadius = kRatio(26);
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

- (UIView *)whiteView{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = kWhiteColor;
        _whiteView.layer.cornerRadius = kRatio(24);
        _whiteView.layer.masksToBounds = YES;
    }
    return _whiteView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.estimatedRowHeight = 44.0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.backgroundColor = [UIColor colorWithHex:0x111111 alpha:0.6];
        [_backButton addTarget:self action:@selector(tapEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)nextButton{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.backgroundColor = kColor_351E29;
        _nextButton.layer.cornerRadius = kRatio(22);
        _nextButton.layer.masksToBounds = YES;
        [_nextButton setTitle:@"Confirm" forState:UIControlStateNormal];
        [_nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _nextButton.titleLabel.font = kFont(18);
        [_nextButton addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.textColor = kBlackColor;
        _tipsLabel.font = kFont(12);
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.text = @"Please confirm relevant information";
    }
    return _tipsLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kColor_351E29;
        _titleLabel.font = kFont(18);
        _titleLabel.text = @"Information Confirmation";
    }
    return _titleLabel;
}

- (UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.layer.cornerRadius = kRatio(12);
        [_closeButton setImage:kGetImage(@"") forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}
// MARK: - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ProductAuthenSectionModel *setionModel = self.viewModel.dataSource[section];
    return setionModel.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductAuthenSectionModel *setionModel = self.viewModel.dataSource[indexPath.section];
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setionModel.cellId forIndexPath:indexPath];
    [cell configData:setionModel.cellData[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)nextStep{
    [[ProductHandle shared] onPushNextStep:self.productId];
}

-(void)tapEvent{
    [self dismissViewControllerAnimated:false completion:nil];
}

-(void)closeEvent{
    [self dismissViewControllerAnimated:false completion:nil];
}
// MARK: - BPProductAuthInfoConfirmViewDelegate
- (void)pickerDate{
    [self showCustomAlertViewWith:[[BPAlertViewModel alloc] init]];
}
@end

NS_ASSUME_NONNULL_END
