//
//  ProdcutAuthenticationTypeViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import "ProdcutAuthenticationTypeViewController.h"
#import "ProdcutAuthenticationTypeViewModel.h"
#import "ProdcutIdIdentityViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutAuthenticationTypeViewController ()<UITableViewDelegate,UITableViewDataSource,ProdcutAuthenticationTypeViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ProdcutAuthenticationTypeViewModel *viewModel;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *navTitle;

@end

@implementation ProdcutAuthenticationTypeViewController

- (instancetype)initWith:(NSString *)productId title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.productId = productId;
        self.navTitle = title;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"Selection mode";
    [self configViewModel];
    [self configUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    [self.tableView.mj_header beginRefreshing];
}

-(void)configUI{
    self.navigationItem.title = @"Product details";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavigationBarHeight);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
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
    self.viewModel = [[ProdcutAuthenticationTypeViewModel alloc] init];
    self.viewModel.delegate = self;
    [self.tableView registerClass:[ProdcutAuthenticationTypeCell class] forCellReuseIdentifier:[[ProdcutAuthenticationTypeCell alloc] init].reuseId];
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

// MARK: - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ProductSectionModel *setionModel = self.viewModel.dataSource[section];
    return setionModel.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductSectionModel *setionModel = self.viewModel.dataSource[indexPath.section];
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setionModel.cellId forIndexPath:indexPath];
    [cell configData:setionModel.cellData[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

// MARK: - ProdcutAuthenticationTypeViewDelegate
- (void)itemSelected:(NSString *)type{
    ProdcutIdIdentityViewController *targetVC = [[ProdcutIdIdentityViewController alloc] initWith:self.productId title:self.navTitle type:type];
    [self.navigationController popCurrentAndPushNewVC:targetVC];
}

@end

NS_ASSUME_NONNULL_END
