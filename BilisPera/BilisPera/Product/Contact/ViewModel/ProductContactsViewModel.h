//
//  ProductContactsViewModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import <Foundation/Foundation.h>
#import "ProductAuthenSectionModel.h"
#import "ProductContactModel.h"
#import "ProductAuthenticationHeaderView.h"
#import "ProductContactEditModel.h"
#import "ProductContactListCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProductContactsViewDelegate <NSObject>

-(void)showPickerView:(NSString *)title key:(NSString *)key options:(NSArray<BPProductFormModel *> *)options;
-(void)openContactsViewWith:(NSString *)key;

@end

@interface ProductContactsViewModel : NSObject

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, weak) id<ProductContactsViewDelegate> delegate;
@property (nonatomic, strong) NSString *currentKey;

-(void)reloadData:(NSString *)productId completion:(simpleCompletion)completion;

- (void)saveUserInfoWithKey:(NSString *)key
                       name:(NSString *)name
                      phone:(NSString *)phone
                relationKey:(NSString *)relationKey
               relationName:(NSString *)relationName;

-(void)updateSections;

-(void)saveUserInfoWith:(NSString *)productId completion:(simpleBoolCompletion)completion;

@end

NS_ASSUME_NONNULL_END
