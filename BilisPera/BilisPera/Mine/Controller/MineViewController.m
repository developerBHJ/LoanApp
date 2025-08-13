//
//  MineViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/5.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "MineViewModel.h"
#import "BPSettingViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,MineViewControllerOrderItemDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MineHeaderView *headerView;
@property (nonatomic, strong) MineViewModel *viewModel;

@end

@implementation MineViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self configViewModel];
    [self configUI];
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
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (MineHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       kScreenW,
                                                                       kRatio(93))];
        _headerView.nickName = [NSString stringWithFormat:@"%@%@",
                                @"ID：",
                                [[[LoginTools shared] getUserName] safePhoneNumberWithLength:4]];
    }
    return _headerView;
}

-(void)configUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavigationBarHeight);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView reloadData];
}

-(void)configViewModel{
    self.viewModel = [[MineViewModel alloc] init];
    self.viewModel.delegate = self;
    for (MineSectionModel *model in self.viewModel.dataSource) {
        [self.tableView registerClass:model.cellType forCellReuseIdentifier:model.cellId];
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineSectionModel *model = self.viewModel.dataSource[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellId forIndexPath:indexPath];
    if ([cell isKindOfClass:[MineOrderCell class]]) {
        NSArray *array = (NSArray *)model.cellData;
        MineOrderCell *orderCell = (MineOrderCell *)cell;
        orderCell.items = array;
        return orderCell;
    }
    if ([cell isKindOfClass:[MineListCell class]]) {
        MineListCellModel *listModel = (MineListCellModel *)model.cellData.firstObject;
        MineListCell *listCell = (MineListCell *)cell;
        listCell.model = listModel ;
        return listCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 0) {
        MineSectionModel *model = self.viewModel.dataSource[indexPath.section];
        MineListCellModel *listModel = (MineListCellModel *)model.cellData.firstObject;
        [self listItemCickEvent:listModel.type];
    }
}


// MARK: - MineViewControllerOrderItemDelegate
- (void)orderItemClick:(BPOrderStatus)status{
    [[Routes shared] onPushOrderView:status];
}

-(void)listItemCickEvent:(MineListType)type{
    switch (type) {
        case BPMineListOnlineService:
            [[Routes shared] onPushWebView:[[HtmlPath getUrl:BPHtmlPathCustomerService] absoluteString]];
            break;
        case BPMineListPrivacy:
            [[Routes shared] onPushWebView:[[HtmlPath getUrl:BPHtmlPathPrivacy] absoluteString]];
            break;
        case BPMineListSetting:
            BPSettingViewController *settingVC = [[BPSettingViewController alloc] init];
            [self.navigationController pushViewController:settingVC animated:YES];
            break;
    }
}
@end

NS_ASSUME_NONNULL_END
