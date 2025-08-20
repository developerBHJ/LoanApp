//
//  ProductBankViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import "ProductBankViewController.h"
#import "ProductBankViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface ProductBankViewController ()<UITableViewDelegate,UITableViewDataSource,ProductPersonalViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ProductBankViewModel *viewModel;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation ProductBankViewController

- (instancetype)initWith:(NSString *)productId title:(NSString *)title type:(NSString *)type{
    if (self = [super initWith:productId title:title]) {
        self.productId = productId;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self configViewModel];
    [self configUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    [self.tableView.mj_header beginRefreshing];
}

-(void)configUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavigationBarHeight);
        make.leading.trailing.equalTo(self.view);
        make.bottom
            .equalTo(self.view)
            .inset(kSafeAreaBottomHeight + kRatio(60));
    }];
    
    [self.view addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view).inset(kRatio(16));
        make.bottom
            .equalTo(self.view)
            .inset(kSafeAreaBottomHeight + kRatio(14));
        make.height.mas_equalTo(kRatio(44));
    }];
    kWeakSelf;
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf reloadData];
    }];
}

-(void)reloadData{
    kWeakSelf;
    [self.viewModel reloadData:self.productId completion:^{
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

-(void)configViewModel{
    self.viewModel = [[ProductBankViewModel alloc] init];
    self.viewModel.delegate = self;
    kWeakSelf;
    self.viewModel.typeChanged = ^{
        [weakSelf.tableView reloadData];
    };
    [self.tableView registerClass:[ProductAuthenticationHeaderView class] forCellReuseIdentifier:[[ProductAuthenticationHeaderView alloc] init].reuseId];
    [self.tableView registerClass:[ProdcutAuthenInputCell class] forCellReuseIdentifier:[[ProdcutAuthenInputCell alloc] init].reuseId];
    [self.tableView registerClass:[ProductBankListCell class] forCellReuseIdentifier:[[ProductBankListCell alloc] init].reuseId];
    [self.tableView registerClass:[ProductBankSegementCell class] forCellReuseIdentifier:[[ProductBankSegementCell alloc] init].reuseId];
    [self.tableView registerClass:[ProdcutAuthenSectionHeaderView class] forHeaderFooterViewReuseIdentifier: [[ProdcutAuthenSectionHeaderView alloc] init].reuseId];
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

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ProductAuthenSectionModel *setionModel = self.viewModel.dataSource[section];
    if (setionModel.headerClass) {
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:setionModel.headerId];
        [headerView configData:setionModel.headerModel];
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    ProductAuthenSectionModel *setionModel = self.viewModel.dataSource[section];
    if (setionModel.headerClass) {
        return setionModel.headerHeight;
    }
    return 0;
}
// MARK: -
-(void)nextStep{
    [self.viewModel saveUserInfoWith:self.productId completion:^(BOOL success) {
        if (success) {
            [[ProductHandle shared] onPushNextStep:self.productId type:@""];
        }
    }];
}

// MARK: - ProductPersonalViewDelegate
- (void)showPickerView:(NSString *)key title:(NSString *)title values:(NSArray<BPProductFormModel *> *)values isAddress:(BOOL)isAddress{
    kWeakSelf;
    if (isAddress) {
        [self showAddressPickerViewSelectedDate:^(NSString *value) {
            BPProductFormEditModel *item = [[BPProductFormEditModel alloc] initWith:key value:value general:@""];
            [weakSelf saveUserInfo:item];
        }];
    }else{
        [self showCommonPickView:title options:values selectedCompletion:^(NSString *value) {
            NSString *optinKey = nil;
            for (BPProductFormModel *option in values) {
                if ([option.tongues isEqualToString:value]) {
                    optinKey = option.everyonehad;
                    break;
                }
            }
            BPProductFormEditModel *item = [[BPProductFormEditModel alloc] initWith:key value:value general:optinKey];
            [weakSelf saveUserInfo:item];
        }];
    }
}

-(void)saveUserInfo:(BPProductFormEditModel *)item{
    [self.viewModel saveEditIndo:item];
    [self.viewModel updateSections];
    [self.tableView reloadData];
}

@end

NS_ASSUME_NONNULL_END
