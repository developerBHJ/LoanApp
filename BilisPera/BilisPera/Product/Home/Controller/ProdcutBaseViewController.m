//
//  ProdcutBaseViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import "ProdcutBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutBaseViewController ()

@property (nonatomic, strong) NSString *navTitle;

@end
@implementation ProdcutBaseViewController

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
    self.navigationItem.title = self.navTitle;
}

-(void)showProductAlertView:(BPProductAlertViewControllerModel *)model{
    BPProductAlertViewController *alertVC = [[BPProductAlertViewController alloc] init];
    [alertVC presentFullScreen];
    [self presentViewController:alertVC animated:false completion:nil];
    alertVC.model = model;
}

-(void)dismisProductAlertView:(simpleCompletion)completion{
    UIViewController *topVC = [UIViewController topMost];
    if ([topVC isKindOfClass:[BPProductAlertViewController class]]) {
        [self dismissViewControllerAnimated:false completion:completion];
    }
}

-(void)showDatePickerView:(NSString *)dafaultDate selectedDate:(simpleStringCompletion)selectedDate{
    BPDatePickerViewModel *model = [[BPDatePickerViewModel alloc] init];
    model.currentDate = dafaultDate;
    __block NSString *tempStr= @"";
    kWeakSelf;
    model.valueChanged = ^(NSString * dateStr) {
        tempStr = dateStr;
    };
    BPDatePickerView *pickView = [[BPDatePickerView alloc] initWithFrame:CGRectZero];
    pickView.model = model;
    BPProductAlertViewControllerModel *viewM = [[BPProductAlertViewControllerModel alloc] init];
    viewM.needConfirm = YES;
    viewM.contentHeight = kRatio(260);
    viewM.confirmCompletion = ^{
        [weakSelf dismisProductAlertView:^{
            selectedDate(tempStr);
        }];
    };
    viewM.headerModel = [[BPAlertHeasderViewModel alloc] initWith:@"Please select a time" needClose:NO completion:^{
        [weakSelf dismisProductAlertView:^{}];
    }];
    viewM.contentView = pickView;
    UIViewController *topVC = [UIViewController topMost];
    if ([topVC isKindOfClass:[ProdcutBaseViewController class]]) {
        ProdcutBaseViewController *baseVC = (ProdcutBaseViewController *)topVC;
        [baseVC showProductAlertView:viewM];
    }
}

-(void)showCommonPickView:(NSString *)title options:(NSArray<BPProductFormModel *> *)options selectedCompletion:(simpleStringCompletion)selectedCompletion{
    if (options.count == 0) {
        return;
    }
    BPAuthenTypeSelectedViewModel *model = [[BPAuthenTypeSelectedViewModel alloc] init];
    model.cellType = [BPAuthenTypeSelectedItemCell class];
    model.dataSource = @[];
    __block NSString *tempStr= @"";
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < options.count; i ++) {
        BPProductFormModel *formModel = options[i];
        BPAuthenTypeSelectedItemCellModel *item = [[BPAuthenTypeSelectedItemCellModel alloc] initWith:formModel.tongues imageUrl:formModel.consulted isSelected:i == 0];
        [tempArray addObject:item];
    }
    model.dataSource = @[[[ProductSectionModel alloc] initWith:[BPAuthenTypeSelectedItemCell class] cellData:tempArray]];
    model.completion = ^(NSString *value) {
        tempStr = value;
    };
    BPAuthenTypeSelectedView *pickerView = [[BPAuthenTypeSelectedView alloc] init];
    pickerView.model = model;
    
    BPProductAlertViewControllerModel *viewM = [[BPProductAlertViewControllerModel alloc] init];
    viewM.needConfirm = YES;
    viewM.contentHeight = kRatio(186);
    kWeakSelf;
    viewM.confirmCompletion = ^{
        [weakSelf dismisProductAlertView:^{
            selectedCompletion(tempStr);
        }];
    };
    viewM.headerModel = [[BPAlertHeasderViewModel alloc] initWith:@"Please select a time" needClose:NO completion:^{
        [weakSelf dismisProductAlertView:^{}];
    }];
    viewM.contentView = pickerView;
    UIViewController *topVC = [UIViewController topMost];
    if ([topVC isKindOfClass:[ProdcutBaseViewController class]]) {
        ProdcutBaseViewController *baseVC = (ProdcutBaseViewController *)topVC;
        [baseVC showProductAlertView:viewM];
    }
}

-(void)showAddressPickerViewSelectedDate:(simpleStringCompletion)selectedDate{
    
    BPAddressPickerViewModel *model = [[BPAddressPickerViewModel alloc] init];
    model.dataSource = [ProductHandle shared].addressList;
    __block NSString *tempStr= @"";
    __block BOOL isCompleted = NO;
    kWeakSelf;
    model.valueChanged = ^(NSString * _Nonnull vaue) {
        tempStr = vaue;
    };
    model.completed = ^(BOOL result) {
        isCompleted = result;
    };
    __block BPAddressPickerView *pickView = [[BPAddressPickerView alloc] initWithFrame:CGRectZero];
    pickView.model = model;
    BPProductAlertViewControllerModel *viewM = [[BPProductAlertViewControllerModel alloc] init];
    viewM.needConfirm = YES;
    viewM.contentHeight = kRatio(260);
    viewM.confirmCompletion = ^{
        if (isCompleted) {
            [weakSelf dismisProductAlertView:^{
                selectedDate(tempStr);
            }];
        }else{
            [pickView nextStep];
        }
    };
    viewM.headerModel = [[BPAlertHeasderViewModel alloc] initWith:@"Please select a time" needClose:NO completion:^{
        [weakSelf dismisProductAlertView:^{}];
    }];
    viewM.contentView = pickView;
    UIViewController *topVC = [UIViewController topMost];
    if ([topVC isKindOfClass:[ProdcutBaseViewController class]]) {
        ProdcutBaseViewController *baseVC = (ProdcutBaseViewController *)topVC;
        [baseVC showProductAlertView:viewM];
    }
}

@end

NS_ASSUME_NONNULL_END
