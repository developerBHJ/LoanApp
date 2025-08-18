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

@end

NS_ASSUME_NONNULL_END
