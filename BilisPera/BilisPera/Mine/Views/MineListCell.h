//
//  MineListCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,MineListType) {
    BPMineListOnlineService = 0,
    BPMineListPrivacy = 1,
    BPMineListSetting = 2,
    BPMineListVersion = 3,
    BPMineListLogOut = 4,
};

@interface MineListCellModel : NSObject

- (instancetype)initWith:(MineListType)type;

@property (nonatomic, assign) MineListType type;

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *imageName;
@property (nonatomic, strong, readonly) NSString *content;

@end

@interface MineListCell : BaseTableViewCell

@property (nonatomic, strong) MineListCellModel *model;

@end

NS_ASSUME_NONNULL_END
