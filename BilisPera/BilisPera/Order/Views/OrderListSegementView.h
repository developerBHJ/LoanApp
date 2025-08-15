//
//  OrderListSegementView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderListSegementViewItemModel : NSObject

@property (nonatomic, assign) BPOrderStatus status;
@property (nonatomic, strong,readonly) NSString *title;
@property (nonatomic, strong,readonly) NSString *imageName;
@property (nonatomic, strong,readonly) NSString *selectedImageName;
@property (nonatomic, assign,readonly) CGFloat itemWidth;
@property (nonatomic, copy,nullable) simpleIntCompletion completion;
- (instancetype)initWith:(BPOrderStatus)status completion:(simpleIntCompletion)completion;

@end

@interface OrderListSegementView : UIView

@property (nonatomic, strong) NSArray<OrderListSegementViewItemModel *>* items;
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<OrderListSegementViewItemModel *> *)items;
@property (nonatomic, assign) NSInteger defaultIndex;

@end

NS_ASSUME_NONNULL_END
