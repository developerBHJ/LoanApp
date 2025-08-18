//
//  HomeViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/5.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "BPCommonQuestionViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,HomePageEventDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HomeViewModel *viewModel;
@property (nonatomic, strong) UIImageView *topBackImageView;

@end

@implementation HomeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [[Routes shared] registerRoutes];
    [self configViewModel];
    [self configUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

-(void)configUI{
    [self.view addSubview:self.topBackImageView];
    [self.topBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(kRatio(302));
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavigationBarHeight);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).inset(kCustomTabBarH - kTabBarHeight);
    }];
    kWeakSelf;
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf reloadData];
    }];
}

-(void)configViewModel{
    self.viewModel = [[HomeViewModel alloc] init];
    self.viewModel.deleagete = self;
}

-(void)registerCells{
    for (HomeSectionModel *model in self.viewModel.dataSource) {
        [self.tableView registerClass:model.cellType forCellReuseIdentifier:model.cellId];
    }
}

- (UIImageView *)topBackImageView{
    if (!_topBackImageView) {
        _topBackImageView = [[UIImageView alloc] init];
        _topBackImageView.image = kGetImage(@"icon_home_bg");
    }
    return _topBackImageView;
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
    HomeSectionModel *setionModel = self.viewModel.dataSource[section];
    return setionModel.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeSectionModel *setionModel = self.viewModel.dataSource[indexPath.section];
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setionModel.cellId forIndexPath:indexPath];
    [cell configData:setionModel.cellData[indexPath.row]];
    return cell;
}

// MARK: - ReloadData
-(void)reloadData{
    kWeakSelf;
    [self.viewModel reloadData:^{
        [weakSelf registerCells];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
// MARK: - HomePageEventDelegate
- (void)onpushOtherView:(NSString *)url{
    [[Routes shared] routeTo:url];
}

- (void)onpushCommonQuestionsView{
    BPCommonQuestionViewController *questionVC = [[BPCommonQuestionViewController alloc] init];
    [self.navigationController pushViewController:questionVC animated:YES];
}

- (void)onPushProductDetail:(NSString *)prodcutId{
    [[ProductHandle shared] onPushDetailView:prodcutId];
}

- (void)kingKongItemClick:(HomeKingKongType)type{
    switch (type) {
        case HomeKingKongTypeOrder:
            [[Routes shared] onPushOrderView:BPOrderStatusAll];
            break;
        case HomeKingKongTypeResponse:
            [[Routes shared] onPushWebView:@""];
            break;
        case HomeKingKongTypeService:
            [[Routes shared] onPushWebView:@""];
            break;
    }
}

@end

NS_ASSUME_NONNULL_END
