//
//  ProdcutAuthenticationResultViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import "ProdcutAuthenticationResultViewController.h"
#import "ProdcutAuthenticationResultViewModel.h"
#import "BPProductAuthenResultView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutAuthenticationResultViewController ()

@property (nonatomic, strong) BPProductAuthenResultView *contentView;
@property (nonatomic, strong) ProdcutAuthenticationResultViewModel *viewModel;

@end

@implementation ProdcutAuthenticationResultViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"Successful certification";
    
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.leading.trailing.equalTo(self.view).inset(kRatio(16));
        make.height.mas_greaterThanOrEqualTo(kRatio(560));
    }];
    
    [self reloadData];
}

-(void)reloadData{
    self.viewModel = [[ProdcutAuthenticationResultViewModel alloc] init];
    kWeakSelf;
    [self.viewModel reloadData:self.productId completion:^{
        [weakSelf configData];
    }];
}

-(void)configData{
    BPProductAuthenResultViewModel *model = [[BPProductAuthenResultViewModel alloc] init];
    model.title = @"Authentication successful";
    model.subTitle = @"Please check that your information is correct and cannot be changed once submitted";
    model.rightImageName = @"icon_auth_success";
    model.imageName = @"icon_auth_result";
    BPProductAuthenResultItemViewModel *item1 = [[BPProductAuthenResultItemViewModel alloc] init:@"Full Name" content:self.viewModel.infoModel.loins.humps.tongues];
    BPProductAuthenResultItemViewModel *item2 = [[BPProductAuthenResultItemViewModel alloc] init:@"ID NO." content:self.viewModel.infoModel.loins.humps.wounds];
    BPProductAuthenResultItemViewModel *item3 = [[BPProductAuthenResultItemViewModel alloc] init:@"Brithday" content:self.viewModel.infoModel.loins.humps.alsowith];
    model.items = @[item1,item2,item3];
    model.completion = ^{
        [[ProductHandle shared] onPushNextStep:self.productId type:@""];
    };
    self.contentView.model = model;
}

- (BPProductAuthenResultView *)contentView{
    if (!_contentView) {
        _contentView = [[BPProductAuthenResultView alloc] initWithFrame:CGRectZero];
    }
    return _contentView;
}

@end

NS_ASSUME_NONNULL_END
