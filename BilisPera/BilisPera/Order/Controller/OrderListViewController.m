//
//  OrderListViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/5.
//

#import "OrderListViewController.h"
#import "OrderListViewModel.h"
#import "OrderListHeaderView.h"
#import "BPEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource,OrderListViewItemClickDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OrderListViewModel *viewModel;
@property (nonatomic, strong) OrderListHeaderView *headrView;
@property (nonatomic, assign) NSInteger currentType;
@property (nonatomic, strong) BPEmptyView *emptyView;
@property (nonatomic, assign) BOOL isNotReachable;

@end

@implementation OrderListViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"Order";
    self.currentType = 4;
    [self configViewModel];
    [self configUI];
    self.isNotReachable = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

-(void)configViewModel{
    self.viewModel = [[OrderListViewModel alloc] init];
    self.viewModel.delegate = self;
    for (OrderListSectionModel *model in self.viewModel.dataSource) {
        [self.tableView registerClass:model.cellType forCellReuseIdentifier:model.cellId];
    }
    [self.tableView reloadData];
}

-(void)configUI{
    [self.view addSubview:self.headrView];
    [self.headrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavigationBarHeight);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(kRatio(124));
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headrView.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [self.view addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headrView.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    kWeakSelf;
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf reloadData];
    }];
    OrderListSegementViewItemModel *item1 = [[OrderListSegementViewItemModel alloc] initWith:BPOrderStatusAll completion:^(NSInteger type) {
        weakSelf.currentType = type;
        [weakSelf reloadData];
    }];
    OrderListSegementViewItemModel *item2 = [[OrderListSegementViewItemModel alloc] initWith:BPOrderStatusApplying completion:^(NSInteger type) {
        weakSelf.currentType = type;
        [weakSelf reloadData];
    }];
    OrderListSegementViewItemModel *item3 = [[OrderListSegementViewItemModel alloc] initWith:BPOrderStatusRepayment completion:^(NSInteger type) {
        weakSelf.currentType = type;
        [weakSelf reloadData];
    }];
    OrderListSegementViewItemModel *item4 = [[OrderListSegementViewItemModel alloc] initWith:BPOrderStatusFinish completion:^(NSInteger type) {
        weakSelf.currentType = type;
        [weakSelf reloadData];
    }];
    NSArray *items = @[item1,item2,item3,item4];
    self.headrView.items = items;
}

-(void)reloadData{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager manager];
    if (manager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [self updateEmptyView:1];
        self.isNotReachable = YES;
    }else{
        kWeakSelf;
        [self.viewModel reloadDataWith:self.currentType completion:^{
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView reloadData];
            if (weakSelf.viewModel.dataSource.count == 0) {
                [weakSelf updateEmptyView:0];
            }else{
                [weakSelf.tableView setHidden:NO];
                [weakSelf.emptyView setHidden:YES];
            }
        }];
        self.isNotReachable = NO;
    }
}

-(void)refreshEvent{
    if (self.isNotReachable) {
        [self reloadData];
    }else{
        [[Routes shared] backToHomeView];
    }
}

-(void)updateEmptyView:(NSInteger)type{
    if (type == 0) {// 无数据
        [self.emptyView updateImage:@"icon_order_empty" message:@"No orders yet." buttonTitle:@"GO Apply"];
    }else{// 无网络
        [self.emptyView updateImage:@"icon_net_error" message:@"Network connection failed\nPlease try again" buttonTitle:@"Try Again"];
    }
    [self.tableView setHidden:YES];
    [self.emptyView setHidden:NO];
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

- (OrderListHeaderView *)headrView{
    if (!_headrView) {
        _headrView = [[OrderListHeaderView alloc] initWithFrame:CGRectMake(0,
                                                                           0,
                                                                           kScreenW,
                                                                           kRatio(124))];
    }
    return _headrView;
}

- (BPEmptyView *)emptyView{
    if (!_emptyView) {
        kWeakSelf;
        _emptyView = [[BPEmptyView alloc] initWithFrame:CGRectZero emptyImage:@"" message:@"" buttonTitle:@"" completion:^{
            [weakSelf refreshEvent];
        }];
    }
    [_emptyView setHidden:YES];;
    return _emptyView;
}

// MARK: - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    OrderListSectionModel *setionModel = self.viewModel.dataSource[section];
    return setionModel.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderListSectionModel *setionModel = self.viewModel.dataSource[indexPath.section];
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setionModel.cellId forIndexPath:indexPath];
    [cell configData:setionModel.cellData[indexPath.row]];
    return cell;
}

// MARK: - OrderListViewItemClickDelegate
- (void)itemClick:(NSString *)url{
    [[Routes shared] routeTo:url];
}

@end




NS_ASSUME_NONNULL_END
