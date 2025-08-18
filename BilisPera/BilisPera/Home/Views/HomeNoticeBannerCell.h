//
//  HomeNoticeBannerCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/16.
//

#import <Foundation/Foundation.h>
#import "HomeNoticeCell.h"

NS_ASSUME_NONNULL_BEGIN
@interface HomeNoticeBannerCellModel : NSObject

@property (nonatomic, strong) NSArray<HomeNoticeCellModel *> *items;

@end


@interface HomeNoticeBannerCell : BaseTableViewCell


@end

NS_ASSUME_NONNULL_END
