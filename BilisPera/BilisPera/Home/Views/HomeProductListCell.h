//
//  HomeProductListCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeProductListCellModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *rate;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *amountDesc;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *buttonTitle;

@property (nonatomic, copy, nullable) simpleStringCompletion completion;
- (instancetype)initWith:(NSString *) title rate:(NSString *)rate duration:(NSString *)duration amount:(NSString *)amount completion:(nullable simpleStringCompletion)completion;

@end

@interface HomeProductListCell : BaseTableViewCell

@end

NS_ASSUME_NONNULL_END
