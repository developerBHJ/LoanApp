//
//  ProdcutIdFaceIDViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import "ProdcutIdFaceIDViewController.h"
#import "BPImagePiakerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutIdFaceIDViewController ()<UITableViewDelegate,UITableViewDataSource,ProdcutIdFaceIDViewDelegate>

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ProdcutIdFaceIDViewModel *viewModel;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation ProdcutIdFaceIDViewController

- (instancetype)initWith:(NSString *)productId title:(NSString *)title type:(NSString *)type{
    if (self = [super initWith:productId title:title]) {
        self.type = type;
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
    self.viewModel = [[ProdcutIdFaceIDViewModel alloc] init];
    self.viewModel.delegate = self;
    self.viewModel.type = self.type;
    [self.tableView registerClass:[ProductAuthenticationHeaderView class] forCellReuseIdentifier:[[ProductAuthenticationHeaderView alloc] init].reuseId];
    [self.tableView registerClass:[ProdcutAuthenticationIndetifyCell class] forCellReuseIdentifier:[[ProdcutAuthenticationIndetifyCell alloc] init].reuseId];
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
    ProductSectionModel *setionModel = self.viewModel.dataSource[section];
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
// MARK: - ProdcutIdIdentityViewDelegate
- (void)pickerImage{
    [self openCameraView];
    [[TrackTools shared] saveTrackTime:BPTrackRiskTypeFaceId start:YES];
}

-(void)openCameraView{
    kWeakSelf;
    [[PermissionTools shared] requestCameraAccessWithCompletion:^(BOOL result) {
        if (result) {
            BPImagePiakerViewController *pickerVC = [[BPImagePiakerViewController alloc] initWithPosition:AVCaptureDevicePositionFront canFlip:NO];
            pickerVC.completion = ^(UIImage * _Nonnull image) {
                weakSelf.viewModel.selectedImage = image;
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    [weakSelf reloadData];
                    [weakSelf uploadImage];
                }];
            };
            [pickerVC presentFullScreen];
            [weakSelf presentViewController:pickerVC animated:YES completion:nil];
        }else{
            [self showCustomAlertWithTitle:@"" message:kCameraAlertMessage confirmCompletion:^{
                [[Routes shared] routeTo:[NSString stringWithFormat:@"%@%@",
                                          kScheme,
                                          [BPRoute settingPage]]];
            } cancelCompletion:^{
                
            }];
        }
    }];
}

-(void)nextStep{
    if (self.viewModel.selectedImage) {
        [self uploadImage];
    }else{
        [self pickerImage];
    }
}

-(void)uploadImage{
    kWeakSelf;
    [self.viewModel uplodaImage:self.productId image:self.viewModel.selectedImage completion:^(BOOL success) {
        if (success) {
            [[TrackTools shared] saveTrackTime:BPTrackRiskTypeFaceId start:NO];
            [[TrackTools shared] trackRiskInfo:BPTrackRiskTypeFaceId productId:weakSelf.productId];
            [[ProductHandle shared] enterAuthenView:weakSelf.productId type:weakSelf.type];
        }
    }];
}
@end

NS_ASSUME_NONNULL_END
