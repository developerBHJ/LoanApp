//
//  OrderListViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/5.
//

#import "OrderListViewController.h"
#import "OrderListViewModel.h"
#import "OrderListHeaderView.h"


NS_ASSUME_NONNULL_BEGIN

@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) OrderListViewModel *viewModel;
@property (nonatomic, strong) OrderListHeaderView *headrView;

@end

@implementation OrderListViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"Order";
    [self configViewModel];
    [self configUI];
}

-(void)configViewModel{
    self.viewModel = [[OrderListViewModel alloc] init];
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
        make.bottom.equalTo(self.view).inset(kCustomTabBarH - kTabBarHeight);
    }];
    OrderListSegementViewItemModel *item1 = [[OrderListSegementViewItemModel alloc] initWith:BPOrderStatusAll completion:^(NSInteger type) {
        
    }];
    OrderListSegementViewItemModel *item2 = [[OrderListSegementViewItemModel alloc] initWith:BPOrderStatusApplying completion:^(NSInteger type) {
        
    }];
    OrderListSegementViewItemModel *item3 = [[OrderListSegementViewItemModel alloc] initWith:BPOrderStatusRepayment completion:^(NSInteger type) {
        
    }];
    OrderListSegementViewItemModel *item4 = [[OrderListSegementViewItemModel alloc] initWith:BPOrderStatusFinish completion:^(NSInteger type) {
        
    }];
    NSArray *items = @[item1,item2,item3,item4];
    self.headrView.items = items;
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


@end




NS_ASSUME_NONNULL_END
