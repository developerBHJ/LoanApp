//
//  BPAuthenTypeSelectedItemCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPAuthenTypeSelectedItemCellModel : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL selected;
- (instancetype)initWith:(NSString *)title imageUrl:(NSString *)imageUrl isSelected:(BOOL)isSelected;

@end

@interface BPAuthenTypeSelectedItemCell : BaseTableViewCell

@end

NS_ASSUME_NONNULL_END
