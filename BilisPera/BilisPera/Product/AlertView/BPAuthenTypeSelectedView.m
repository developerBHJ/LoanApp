//
//  BPAuthenTypeSelectedView.m
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import "BPAuthenTypeSelectedView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPAuthenTypeSelectedViewModel

@end

@interface BPAuthenTypeSelectedView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BPAuthenTypeSelectedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame model:(BPAuthenTypeSelectedViewModel *)model {
    self = [super initWithFrame:frame];
    if (self) {
        _model = model;
        [self configUI];
    }
    return self;
}

-(void)configUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.leading.trailing.equalTo(self).inset(kRatio(12));
    }];
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

- (void)setModel:(BPAuthenTypeSelectedViewModel *)model{
    _model = model;
    [self.tableView registerClass:model.cellType forCellReuseIdentifier:[[[model.cellType alloc] init] reuseId]];
    [self.tableView reloadData];
    [self tableView:self.tableView didSelectRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0]];
}

// MARK: - UITableViewDelegate,UITableViewDataSource
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ProductSectionModel *sectionModel = self.model.dataSource[section];
    return sectionModel.cellData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductSectionModel *sectionModel = self.model.dataSource[indexPath.section];
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionModel.cellId forIndexPath:indexPath];
    if (indexPath.row < sectionModel.cellData.count) {
        [cell configData:sectionModel.cellData[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRatio(66);
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductSectionModel *sectionModel = self.model.dataSource[indexPath.section];
    NSMutableArray *newCellModels = [NSMutableArray array];
    if ([sectionModel.cellData.firstObject isKindOfClass:[NSObject class]]) {
        [sectionModel.cellData enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                                            NSUInteger idx,
                                                            BOOL * _Nonnull stop) {
            BPAuthenTypeSelectedItemCellModel *model = (BPAuthenTypeSelectedItemCellModel *)obj;
            model.selected = (idx == indexPath.row);
            if (model.selected) {
                if (self.model.completion) {
                    self.model.completion(model.title);
                }
            }
            [newCellModels addObject:model];
        }];
    }
    NSMutableArray *newDataSource = [self.model.dataSource mutableCopy];
    sectionModel.cellData = newCellModels;
    [newDataSource replaceObjectAtIndex:indexPath.section withObject:sectionModel];
    self.model.dataSource = [newDataSource copy];
    [self.tableView reloadData];
}

@end

NS_ASSUME_NONNULL_END
