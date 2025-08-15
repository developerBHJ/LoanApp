//
//  BPCommonQuestionViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "BPCommonQuestionViewController.h"
#import "BPCommonQuestionsHeaderView.h"
#import "BPCommonQuestionViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPCommonQuestionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BPCommonQuestionsHeaderView *headrView;
@property (nonatomic, strong) BPCommonQuestionViewModel *viewModel;

@end

@implementation BPCommonQuestionViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"Common Qs";
    [self configViewModel];
    [self configUI];
}

-(void)configViewModel{
    self.viewModel = [[BPCommonQuestionViewModel alloc] init];
    for (HomeSectionModel *model in self.viewModel.dataSource) {
        [self.tableView registerClass:model.cellType forCellReuseIdentifier:model.cellId];
    }
}

-(void)configUI{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavigationBarHeight);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    self.tableView.tableHeaderView = self.headrView;
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

- (BPCommonQuestionsHeaderView *)headrView{
    if (!_headrView) {
        _headrView = [[BPCommonQuestionsHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kRatio(117))];
    }
    return _headrView;
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


@end

NS_ASSUME_NONNULL_END
