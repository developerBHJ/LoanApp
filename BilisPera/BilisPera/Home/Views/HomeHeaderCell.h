//
//  HomeHeaderCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeaderCellModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *rate;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *buttonTitle;
@property (nonatomic, copy,nullable) simpleStringCompletion completion;

@end

@interface HomeHeaderCell : BaseTableViewCell

@end

NS_ASSUME_NONNULL_END
