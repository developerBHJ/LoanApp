//
//  HomeKingKongCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HomeKingKongType) {
    HomeKingKongTypeOrder = 0,
    HomeKingKongTypeResponse,
    HomeKingKongTypeService,
};

typedef void(^homeKingKongItemClick)(HomeKingKongType);

@interface HomeKingKongItemViewModel : NSObject

@property (nonatomic, assign) HomeKingKongType type;
- (instancetype)initWith:(HomeKingKongType)type;

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *subTitle;
@property (nonatomic, strong, readonly) NSString *imageName;
@property (nonatomic, strong, readonly) UIColor *backColor;

@property (nonatomic, copy, nullable) homeKingKongItemClick completion;

@end

@interface HomeKingKongCellModel : NSObject

@property (nonatomic, strong) NSArray<HomeKingKongItemViewModel *> *items;

@end

@interface HomeKingKongCell : BaseTableViewCell

@end

NS_ASSUME_NONNULL_END
