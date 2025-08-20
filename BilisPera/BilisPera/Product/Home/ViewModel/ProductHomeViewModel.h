//
//  ProductHomeViewModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/15.
//

#import <Foundation/Foundation.h>
#import "ProductSectionModel.h"
#import "ProductHomeHeaderView.h"
#import "ProductHomeStepCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductHomeViewModel : NSObject

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSString *productId;

-(void)reloadDataWithProductId:(NSString *)productId completion:(simpleCompletion)completion;

@end

NS_ASSUME_NONNULL_END
