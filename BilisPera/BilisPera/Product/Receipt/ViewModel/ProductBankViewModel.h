//
//  ProductBankViewModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import <Foundation/Foundation.h>
#import "ProductAuthenSectionModel.h"
#import "ProdcutAuthenInputCell.h"
#import "ProductBankListModel.h"
#import "ProductAuthenticationHeaderView.h"
#import "ProductBankListCell.h"
#import "ProdcutAuthenSectionHeaderView.h"
#import "ProductBankSegementCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductBankViewModel : NSObject

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, weak) id<ProductPersonalViewDelegate> delegate;
@property (nonatomic, assign) NSInteger selectedType;
@property (nonatomic, strong) NSArray<NSString *> *segementTitles;
@property (nonatomic, strong) NSArray<NSNumber *> *segementValues;
@property (nonatomic, copy)  simpleCompletion typeChanged;

-(void)reloadData:(NSString *)productId completion:(simpleCompletion)completion;

-(void)saveEditIndo:(BPProductFormEditModel *)item;

-(void)updateSections;

-(void)saveUserInfoWith:(NSString *)productId completion:(simpleBoolCompletion)completion;

@end

NS_ASSUME_NONNULL_END
