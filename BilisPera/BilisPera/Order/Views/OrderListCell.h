//
//  OrderListCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,OrderListType) {
    OrderListTypeDelay = 1,
    OrderListTypeRepayment = 2,
    OrderListTypeApply = 3,
    OrderListTypeReview = 4,
    OrderListTypeFinish = 5,
};

@interface OrderListCellModel : NSObject

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *amountDesc;
@property (nonatomic, strong) NSString *dateStr;
@property (nonatomic, strong) NSString *buttonTitle;
@property (nonatomic, strong) NSString *remind;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, assign) OrderListType type;
@property (nonatomic, strong,readonly) NSString *typeImage;
@property (nonatomic, strong,readonly) UIColor *typeBackColor;
@property (nonatomic, copy, nullable) simpleStringCompletion completion;

@end

@interface OrderListCell : BaseTableViewCell


@end

NS_ASSUME_NONNULL_END
