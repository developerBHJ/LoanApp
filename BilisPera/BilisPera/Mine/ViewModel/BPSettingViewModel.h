//
//  BPSettingViewModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import <Foundation/Foundation.h>
#import "MineSectionModel.h"
#import "BPSettingListCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPSettingViewModel : NSObject

@property (nonatomic, strong) NSArray<MineSectionModel *> *dataSource;

@end

NS_ASSUME_NONNULL_END
