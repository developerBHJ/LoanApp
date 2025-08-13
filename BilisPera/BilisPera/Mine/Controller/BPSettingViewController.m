//
//  BPSettingViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import "BPSettingViewController.h"
#import "BPSettingHeaderView.h"
#import "BPSettingViewModel.h"
#import "BPSettingFooterView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BPSettingHeaderView *headerView;
@property (nonatomic, strong) BPSettingViewModel *viewModel;
@property (nonatomic, strong) BPSettingFooterView *footerView;

@end

@implementation BPSettingViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"settings";
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
        [_tableView setScrollEnabled:NO];
    }
    return _tableView;
}

- (BPSettingHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[BPSettingHeaderView alloc] initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            kScreenW,
                                                                            kRatio(100))];
    }
    return _headerView;
}

- (BPSettingFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[BPSettingFooterView alloc] initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            kScreenW,
                                                                            kRatio(65))];
    }
    return _footerView;
}

-(void)configUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavigationBarHeight);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    [self.tableView reloadData];
    kWeakSelf;
    self.footerView.completion = ^{
        [weakSelf logOff];
    };
}

-(void)configViewModel{
    self.viewModel = [[BPSettingViewModel alloc] init];
    for (MineSectionModel *model in self.viewModel.dataSource) {
        [self.tableView registerClass:model.cellType forCellReuseIdentifier:model.cellId];
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MineSectionModel *model = self.viewModel.dataSource[section];
    return model.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineSectionModel *model = self.viewModel.dataSource[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.cellId forIndexPath:indexPath];
    if ([cell isKindOfClass:[BPSettingListCell class]]) {
        MineListCellModel *cellModel = model.cellData[indexPath.row];
        BPSettingListCell *listCell = (BPSettingListCell *)cell;
        listCell.model = cellModel;
        return listCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MineSectionModel *model = self.viewModel.dataSource[indexPath.section];
    MineListCellModel *listModel = (MineListCellModel *)model.cellData[indexPath.row];
    [self listItemCickEvent:listModel.type];
}

-(void)listItemCickEvent:(MineListType)type{
    switch (type) {
        case BPMineListVersion:
            [BPProressHUD showToastWithView:nil message:[NSString stringWithFormat:@"%@%@",
                                                         @"Version: ",
                                                         kAppVersion]];
            break;
        case BPMineListLogOut:
            [self logOut];
            break;
        default:
            break;
    }
}

-(void)logOut{
    BPAlertViewModel *model = [[BPAlertViewModel alloc] initWith:BPAlertViewTypeExit];
    kWeakSelf;
    model.confirmCompletion = ^{
        [weakSelf dismisCustomAlertView:nil];
    };
    model.cancelCompletion = ^{
        [weakSelf dismisCustomAlertView:nil];
    };
    [self  showCustomAlertViewWith:model];
}

-(void)logOff{
    BPAlertViewModel *model = [[BPAlertViewModel alloc] initWith:BPAlertViewTypeCancellation];
    kWeakSelf;
    model.confirmCompletion = ^{
        [weakSelf dismisCustomAlertView:nil];
    };
    model.cancelCompletion = ^{
        [weakSelf dismisCustomAlertView:nil];
    };
    model.selectedCompletion = ^(BOOL selected) {
        
    };
    [self  showCustomAlertViewWith:model];
}


@end

NS_ASSUME_NONNULL_END
