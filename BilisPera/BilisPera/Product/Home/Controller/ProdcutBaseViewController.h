//
//  ProdcutBaseViewController.h
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import <Foundation/Foundation.h>
#import "BPProductAlertViewController.h"
#import "BPAuthenTypeSelectedView.h"
#import "ProductPersonalModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProductPersonalViewDelegate <NSObject>

-(void)showPickerView:(NSString *)key title:(NSString *)title values:(NSArray<BPProductFormModel *> *)values isAddress:(BOOL)isAddress;

@end

@interface ProdcutBaseViewController : BaseViewController

@property (nonatomic, strong) NSString *productId;
- (instancetype)initWith:(NSString *)productId title:(NSString *)title;

-(void)showProductAlertView:(BPProductAlertViewControllerModel *)model;
-(void)dismisProductAlertView:(simpleCompletion)completion;
-(void)showDatePickerView:(NSString *)dafaultDate selectedDate:(simpleStringCompletion)selectedDate;
-(void)showCommonPickView:(NSString *)title options:(NSArray<BPProductFormModel *> *)options selectedCompletion:(simpleStringCompletion)selectedCompletion;
-(void)showAddressPickerView:(NSString *)title selectedDate:(simpleStringCompletion)selectedDate;

@end

NS_ASSUME_NONNULL_END
