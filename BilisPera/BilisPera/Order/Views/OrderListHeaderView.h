//
//  OrderListHeaderView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import <Foundation/Foundation.h>
#import "OrderListSegementView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderListHeaderView : UIView

- (instancetype)initWithFrame:(CGRect)frame items:(nonnull NSArray<OrderListSegementViewItemModel *> *)items;
@property (nonatomic, strong) NSArray<OrderListSegementViewItemModel *> *items;

@end

NS_ASSUME_NONNULL_END
