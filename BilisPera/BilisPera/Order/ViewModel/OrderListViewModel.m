//
//  OrderListViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "OrderListViewModel.h"
#import "OrderListModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface OrderListViewModel ()

@property (nonatomic, strong) NSArray<OrderListModel *>* orderList;

@end


@implementation OrderListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configData];
    }
    return self;
}

-(void)configData{
    OrderListSectionModel *section = [[OrderListSectionModel alloc] initWith:[OrderListCell class] cellData:@[]];
    self.dataSource = @[section];
}

-(OrderListSectionModel *)configList{
    if (self.orderList.count > 0) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.orderList.count; i ++) {
            OrderListModel *orderInfo = self.orderList[i];
            OrderListCellModel *model = [[OrderListCellModel alloc] init];
            model.type = orderInfo.forwe.wepicketed;
            model.name = [NSString stringWithFormat:@"%@",
                          orderInfo.forwe.stew];
            model.amount = [NSString stringWithFormat:@"%@%@",
                            @"₱",
                            orderInfo.forwe.outsiders];
            model.amountDesc = [NSString stringWithFormat:@"%@",
                                orderInfo.forwe.bluffs];
            model.dateStr = [NSString stringWithFormat:@"%@%@%@",
                             orderInfo.forwe.istheir,@"：",
                             orderInfo.forwe.expedient];
            model.buttonTitle = [NSString stringWithFormat:@"%@",
                                 orderInfo.forwe.choosing];
            model.status = [NSString stringWithFormat:@"%@",
                            orderInfo.forwe.knolls];
            model.remind = [NSString stringWithFormat:@"%@",
                            orderInfo.forwe.sky];
            model.productId = [NSString stringWithFormat:@"%ld",
                               orderInfo.forwe.myinexperience];
            model.orderId = [NSString stringWithFormat:@"%ld",
                             orderInfo.forwe.somner];
            model.imageUrl = [NSString stringWithFormat:@"%@",
                              orderInfo.forwe.hens];
            model.linkUrl = [NSString stringWithFormat:@"%@",
                             orderInfo.forwe.nearest];
            kWeakSelf;
            model.completion = ^(NSString *productId) {
                if ([weakSelf.delegate respondsToSelector:@selector(itemClick:)]) {
                    [weakSelf.delegate itemClick:productId];
                }
            };
            [tempArray addObject:model];
        }
        OrderListSectionModel *section = [[OrderListSectionModel alloc] initWith:[OrderListCell class] cellData:tempArray];
        return section;
    }else{
        return nil;
    }
}

-(void)reloadDataWith:(NSInteger)type completion:(simpleCompletion)completion{
    self.orderList = [[NSArray alloc] init];
    kWeakSelf;
    [[HttpManager shared] requestWithService:OrderList parameters:@{@"dipping":@(type)} showLoading:YES showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        NSArray *list = response.couldsee[@"andwalked"];
        if (list) {
            weakSelf.orderList = [OrderListModel mj_objectArrayWithKeyValuesArray:list];
        }
        OrderListSectionModel *section = [weakSelf configList];
        if (section) {
            weakSelf.dataSource = @[section];
        }else{
            weakSelf.dataSource = @[];
        }
        completion();
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        weakSelf.dataSource = @[];
        completion();
    }];
}

@end

NS_ASSUME_NONNULL_END
