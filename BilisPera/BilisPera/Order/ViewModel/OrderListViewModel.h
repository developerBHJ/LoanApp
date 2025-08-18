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

@protocol OrderListViewItemClickDelegate <NSObject>

-(void)itemClick:(NSString *)orderId;

@end

@interface OrderListViewModel : NSObject

@property (nonatomic, strong) NSArray *dataSource;
-(void)reloadDataWith:(NSInteger)type completion:(simpleCompletion)completion;
@property (nonatomic, weak) id <OrderListViewItemClickDelegate> delegate;;

@end

NS_ASSUME_NONNULL_END
