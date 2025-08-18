//
//  ProdcutBaseViewController.h
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import <Foundation/Foundation.h>
#import "BPProductAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutBaseViewController : BaseViewController

@property (nonatomic, strong) NSString *productId;
- (instancetype)initWith:(NSString *)productId title:(NSString *)title;

-(void)showProductAlertView:(BPProductAlertViewControllerModel *)model;
-(void)dismisProductAlertView:(simpleCompletion)completion;

@end

NS_ASSUME_NONNULL_END
