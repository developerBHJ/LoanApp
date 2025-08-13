//
//  MineViewModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import <Foundation/Foundation.h>
#import "MineSectionModel.h"
#import "MineOrderCell.h"
#import "MineListCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MineViewControllerOrderItemDelegate <NSObject>

-(void)orderItemClick:(BPOrderStatus)status;

@end

@interface MineViewModel : NSObject

@property (nonatomic, strong) NSArray<MineSectionModel *> *dataSource;
@property (nonatomic, weak, nullable) id <MineViewControllerOrderItemDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
