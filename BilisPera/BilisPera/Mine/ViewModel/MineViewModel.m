//
//  MineViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import "MineViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MineViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configData];
    }
    return self;
}

-(void)configData{
    kWeakSelf;
    MineOrderCellModel *allOrder = [[MineOrderCellModel alloc] initWith:BPOrderStatusAll itemClick:^(BPOrderStatus status) {
        [weakSelf.delegate orderItemClick:status];
    }];
    MineOrderCellModel *applyingOrder = [[MineOrderCellModel alloc] initWith:BPOrderStatusApplying itemClick:^(BPOrderStatus status) {
        [weakSelf.delegate orderItemClick:status];
    }];
    MineOrderCellModel *repaymentOrder = [[MineOrderCellModel alloc] initWith:BPOrderStatusRepayment itemClick:^(BPOrderStatus status) {
        [weakSelf.delegate orderItemClick:status];
    }];
    MineOrderCellModel *finishOrder = [[MineOrderCellModel alloc] initWith:BPOrderStatusFinish itemClick:^(BPOrderStatus status) {
        [weakSelf.delegate orderItemClick:status];
    }];
    MineSectionModel *sectionModel = [[MineSectionModel alloc] initWith:[MineOrderCell class] cellData:@[allOrder,
                                                                                                         applyingOrder,
                                                                                                         repaymentOrder,
                                                                                                         finishOrder]];
    MineListCellModel *serviceModel = [[MineListCellModel alloc] initWith:BPMineListOnlineService];
    MineListCellModel *privacyModel = [[MineListCellModel alloc] initWith:BPMineListPrivacy];
    MineListCellModel *settingModel = [[MineListCellModel alloc] initWith:BPMineListSetting];
    MineSectionModel *sectionModel1 = [[MineSectionModel alloc] initWith:[MineListCell class] cellData:@[serviceModel]];
    MineSectionModel *sectionModel2 = [[MineSectionModel alloc] initWith:[MineListCell class] cellData:@[privacyModel]];
    MineSectionModel *sectionModel3 = [[MineSectionModel alloc] initWith:[MineListCell class] cellData:@[settingModel]];
    self.dataSource = @[sectionModel,sectionModel1,sectionModel2,sectionModel3];
}

@end

NS_ASSUME_NONNULL_END
