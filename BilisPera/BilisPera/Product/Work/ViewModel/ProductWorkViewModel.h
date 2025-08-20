//
//  ProductWorkViewModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import <Foundation/Foundation.h>
#import "ProductAuthenSectionModel.h"
#import "ProdcutAuthenInputCell.h"
#import "ProductPersonalModel.h"
#import "ProductAuthenticationHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductWorkViewModel : NSObject

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, weak) id<ProductPersonalViewDelegate> delegate;

-(void)reloadData:(NSString *)productId completion:(simpleCompletion)completion;

-(void)saveEditIndo:(BPProductFormEditModel *)item;

-(void)updateSections;

-(void)saveUserInfoWith:(NSString *)productId completion:(simpleBoolCompletion)completion;

@end

NS_ASSUME_NONNULL_END
