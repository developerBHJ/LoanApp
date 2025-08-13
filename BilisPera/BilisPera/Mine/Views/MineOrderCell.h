//
//  MineOrderCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BPOrderItemCompletion)(BPOrderStatus);

@interface MineOrderCellModel : NSObject

- (instancetype)initWith:(BPOrderStatus)status itemClick:(BPOrderItemCompletion)itemClick;

@property (nonatomic, assign) BPOrderStatus status;
@property (nonatomic, copy, nullable) BPOrderItemCompletion itemClick;

@property (nonatomic, strong,readonly) NSString *title;
@property (nonatomic, strong,readonly) NSString *imageName;

@end

@protocol MineOrderCellDelegate <NSObject>

-(void)orderItemClick:(BPOrderStatus)status;

@end
@interface MineOrderCell : BaseTableViewCell

@property (nonatomic, strong) NSArray<MineOrderCellModel *> *items;
@property (nonatomic, weak, nullable) id <MineOrderCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
