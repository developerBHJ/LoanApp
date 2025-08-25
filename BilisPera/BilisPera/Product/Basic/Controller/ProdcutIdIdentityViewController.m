//
//  ProdcutIdIdentityViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import "ProdcutIdIdentityViewController.h"
#import "ProdcutIdIdentityViewModel.h"
#import "BPImageSelectedAlertView.h"
#import "BPProductAuthInfoConfirmViewController.h"
#import "BPImagePiakerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutIdIdentityViewController ()<UITableViewDelegate,UITableViewDataSource,ProdcutIdIdentityViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ProdcutIdIdentityViewModel *viewModel;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation ProdcutIdIdentityViewController

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
    self.viewModel = [[ProdcutIdIdentityViewModel alloc] init];
    self.viewModel.delegate = self;
    self.viewModel.type = self.type;
    [self.tableView registerClass:[ProductAuthenticationHeaderView class] forCellReuseIdentifier:[[ProductAuthenticationHeaderView alloc] init].reuseId];
    [self.tableView registerClass:[ProdcutAuthenticationIndetifyCell class] forCellReuseIdentifier:[[ProdcutAuthenticationIndetifyCell alloc] init].reuseId];
    [self.tableView registerClass:[ProdcutAuthenticationUserInfoCell class] forCellReuseIdentifier:[[ProdcutAuthenticationUserInfoCell alloc] init].reuseId];
    [self.tableView registerClass:[ProdcutAuthenSectionHeaderView class] forHeaderFooterViewReuseIdentifier: [[ProdcutAuthenSectionHeaderView alloc] init].reuseId];
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

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ProductAuthenSectionModel *setionModel = self.viewModel.dataSource[section];
    if (setionModel.headerClass) {
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:setionModel.headerId];
        [headerView configData:setionModel.headerModel];
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    ProductAuthenSectionModel *setionModel = self.viewModel.dataSource[section];
    if (setionModel.headerClass) {
        return setionModel.headerHeight;
    }
    return 0;
}
// MARK: - ProdcutIdIdentityViewDelegate
- (void)pickerImage{
    if (self.viewModel.infoModel.everyonehad == 1) {
        BPProductAlertViewControllerModel *model = [[BPProductAlertViewControllerModel alloc] init];
        kWeakSelf;
        model.headerModel = [[BPAlertHeasderViewModel alloc] initWith:@"Upload mode" needClose:YES completion:^{
            [weakSelf dismisProductAlertView:^{
            }];
        }];
        BPImageSelectedAlertViewModel *typeModel = [[BPImageSelectedAlertViewModel alloc] init];
        typeModel.selectedCompletion = ^(NSInteger type) {
            weakSelf.viewModel.imageSource += 1;
            [weakSelf dismisProductAlertView:^{
                if (type == 0) {
                    [weakSelf openCameraView];
                }else{
                    [weakSelf openImageLibraryView];
                }
            }];
        };
        BPImageSelectedAlertView *typeView = [[BPImageSelectedAlertView alloc] initWithFrame:CGRectZero model:typeModel];
        model.contentView = typeView;
        model.contentHeight = kRatio(203);
        model.needConfirm = NO;
        [self showProductAlertView:model];
    }else{
        [self openCameraView];
    }
    [[TrackTools shared] saveTrackTime:BPTrackRiskTypeIdInfo start:YES];
}

- (void)pickerDate{
    kWeakSelf;
    [self showDatePickerView:self.viewModel.birthDay selectedDate:^(NSString *dateStr) {
        weakSelf.viewModel.birthDay = dateStr;
        [weakSelf.viewModel configData];
        [weakSelf.tableView reloadData];
    }];
}

-(void)openCameraView{
    kWeakSelf;
    [[PermissionTools shared] requestCameraAccessWithCompletion:^(BOOL result) {
        if (result) {
            BPImagePiakerViewController *pickerVC = [[BPImagePiakerViewController alloc] initWithPosition:AVCaptureDevicePositionBack canFlip:YES];
            pickerVC.completion = ^(UIImage * _Nonnull image) {
                weakSelf.viewModel.selectedImage = image;
                [weakSelf dismissViewControllerAnimated:YES completion:^{
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

-(void)openImageLibraryView{
    kWeakSelf;
    [[PermissionTools shared] requestCameraAccessWithCompletion:^(BOOL result) {
        if (result) {
            UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
            pickerVC.delegate = self;
            pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerVC.allowsEditing = NO;
            [pickerVC presentFullScreen];
            [weakSelf presentViewController:pickerVC animated:YES completion:nil];
        }else{
            [self showCustomAlertWithTitle:@"" message:kAlbumAlertMessage confirmCompletion:^{
                [[Routes shared] routeTo:[NSString stringWithFormat:@"%@%@",
                                          kScheme,
                                          [BPRoute settingPage]]];
            } cancelCompletion:^{
                
            }];
        }
    }];
}


-(void)nextStep{
    if (self.viewModel.userName.length > 0 && self.viewModel.idNumber.length > 0 && self.viewModel.birthDay.length > 0) {
        NSDictionary *paramas = @{@"alsowith":self.viewModel.birthDay,
                                  @"wounds":self.viewModel.idNumber,
                                  @"tongues":self.viewModel.userName,
                                  @"everyonehad":@"11",
                                  @"whispered":[NSString randomString],
                                  @"tender":self.type};
        [self saveuserInfo:paramas];
        return;
    }
    if (self.viewModel.selectedImage) {
        [self uploadImage];
    }else{
        [self pickerImage];
    }
}

-(void)saveuserInfo:(NSDictionary *)paramas{
    kWeakSelf;
    [[ProductHandle shared] saveUserInfoWithParamaters:paramas completion:^(BOOL success) {
        if (success) {
            [[ProductHandle shared] enterAuthenView:weakSelf.productId type:weakSelf.type];
        }
    }];
}

-(void)uploadImage{
    kWeakSelf;
    [self.viewModel uplodaImage:self.productId image:self.viewModel.selectedImage  completion:^(id obj) {
        ProductAuthenIndetyInfoModel *model = [[ProductAuthenIndetyInfoModel alloc] init];
        if ([obj isKindOfClass:[ProductAuthenIndetyInfoModel class]]) {
            model = (ProductAuthenIndetyInfoModel *)obj;
        }
        [[TrackTools shared] saveTrackTime:BPTrackRiskTypeIdInfo start:NO];
        [[TrackTools shared] trackRiskInfo:BPTrackRiskTypeIdInfo productId:weakSelf.productId];
        BPProductAuthInfoConfirmViewController *confirmVC = [[BPProductAuthInfoConfirmViewController alloc] initWith:model productId:weakSelf.productId type:weakSelf.type completion:^() {
            [[ProductHandle shared] enterAuthenView:weakSelf.productId type:weakSelf.type];
        }];
        [confirmVC presentFullScreen];
        [weakSelf presentViewController:confirmVC animated:NO completion:nil];
    }];
}

// MARK: - UIImagePickerControllerDelegate&UINavigationControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (image) {
        self.viewModel.selectedImage = image;
    }
    kWeakSelf;
    [self dismissViewControllerAnimated:YES completion:^{
        [weakSelf reloadData];
        [weakSelf uploadImage];
    }];
}
@end

NS_ASSUME_NONNULL_END
