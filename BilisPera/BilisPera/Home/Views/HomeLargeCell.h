//
//  HomeLargeCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import <Foundation/Foundation.h>
#import "HomeLargeItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeLargeCellModel : NSObject

@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, strong) NSArray *items;
- (instancetype)initWith:(NSArray *)items;

@end

@interface HomeLargeCell : BaseTableViewCell

@end

NS_ASSUME_NONNULL_END
