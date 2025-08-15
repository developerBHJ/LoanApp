//
//  OrderListViewModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import <Foundation/Foundation.h>
#import "HomeSectionModel.h"
#import "OrderListCell.h"
#import "OrderListSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderListViewModel : NSObject

@property (nonatomic, strong) NSArray *dataSource;

@end

NS_ASSUME_NONNULL_END
