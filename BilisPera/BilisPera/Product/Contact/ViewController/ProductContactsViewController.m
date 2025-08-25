//
//  ProductContactsViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import "ProductContactsViewController.h"
#import "ContactsUI/ContactsUI.h"
#import "BPContactsTools.h"

NS_ASSUME_NONNULL_BEGIN
@interface ProductContactsViewController ()<UITableViewDelegate,UITableViewDataSource,ProductContactsViewDelegate,CNContactPickerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ProductContactsViewModel *viewModel;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation ProductContactsViewController

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
    [[TrackTools shared] saveTrackTime:BPTrackRiskTypeContacts start:YES];
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
    self.viewModel = [[ProductContactsViewModel alloc] init];
    self.viewModel.delegate = self;
    [self.tableView registerClass:[ProductAuthenticationHeaderView class] forCellReuseIdentifier:[[ProductAuthenticationHeaderView alloc] init].reuseId];
    [self.tableView registerClass:[ProductContactListCell class] forCellReuseIdentifier:[[ProductContactListCell alloc] init].reuseId];
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

-(void)nextStep{
    kWeakSelf;
    [self.viewModel saveUserInfoWith:self.productId completion:^(BOOL success) {
        if (success) {
            [[TrackTools shared] saveTrackTime:BPTrackRiskTypeContacts start:NO];
            [[TrackTools shared] trackRiskInfo:BPTrackRiskTypeContacts productId:weakSelf.productId];
            [[ProductHandle shared] enterAuthenView:weakSelf.productId type:@""];
        }
    }];
}

// MARK: - ProductContactsViewDelegate
- (void)showPickerView:(NSString *)title key:(NSString *)key options:(NSArray<BPProductFormModel *> *)options{
    kWeakSelf;
    [self showCommonPickView:title options:options selectedCompletion:^(NSString *value) {
        NSString *optionKey = nil;
        for (BPProductFormModel *option in options) {
            if ([option.tongues isEqualToString:value]) {
                optionKey = option.everyonehad;
                break;
            }
        }
        [weakSelf saveUserInfo:key relation:value relationKey:optionKey];
    }];
}

- (void)openContactsViewWith:(NSString *)key{
    kWeakSelf;
    [[PermissionTools shared] requestContactsAccessWithCompletion:^(BOOL success) {
        if (success) {
            CNContactPickerViewController *pickVC = [[CNContactPickerViewController alloc] init];
            pickVC.delegate = weakSelf;
            pickVC.predicateForEnablingContact = [NSPredicate predicateWithFormat:@"phoneNumbers.@count > 0"];
            [self presentViewController:pickVC animated:NO completion:nil];
            [weakSelf trackContactsInfo];
        }else{
            [self showCustomAlertWithTitle:@"" message:kContactsAlertMessage confirmCompletion:^{
                [[Routes shared] routeTo:[NSString stringWithFormat:@"%@%@",
                                          kScheme,
                                          [BPRoute settingPage]]];
            } cancelCompletion:^{
                
            }];
        }
    }];
}

-(void)saveUserInfo:(NSString *)key relation:(NSString *)relation relationKey:(NSString *)relationKey{
    [self.viewModel saveUserInfoWithKey:key name:@"" phone:@"" relationKey:relationKey relationName:relation];
    [self.viewModel updateSections];
    [self.tableView reloadData];
}


-(void)trackContactsInfo{
    [[BPContactsTools shared] fetchContactsAsJSON:^(NSString *contactJson) {
        if (contactJson.length > 0) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            dic[@"everyonehad"] = @"3";
            dic[@"withdiminished"] = [NSString randomString];
            dic[@"cavalcade"] = [NSString randomString];
            dic[@"couldsee"] = contactJson;
            dispatch_async(dispatch_get_main_queue(), ^{
                [[TrackTools shared] trackContactsInfo:dic];
            });
        }
    }];
}
// MARK: - CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    NSString *fullName = [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName] ?: @"";
    NSString *phoneNum = @"";
    if (contact.phoneNumbers.firstObject) {
        phoneNum = contact.phoneNumbers.firstObject.value.stringValue;
    }
    if (fullName.length == 0 && phoneNum.length == 0) {
        [BPProressHUD showToastWithView:nil message:@"The name and phone number of the contact person cannot be empty"];
        return;
    }
    [self.viewModel saveUserInfoWithKey:self.viewModel.currentKey name:fullName phone:phoneNum relationKey:@"" relationName:@""];
    [self.viewModel updateSections];
    [self.tableView reloadData];
}

@end

NS_ASSUME_NONNULL_END
