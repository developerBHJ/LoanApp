//
//  HomeViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/13.
//

#import "HomeViewModel.h"
#import "HomeSectionModel.h"
#import "HomePageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel ()
@property (nonatomic, strong) HomePageModel *pageModel;
// 是否大卡位
@property (nonatomic, assign) BOOL isLarge;
// 大卡位是否显示下面的模块
@property (nonatomic, assign) BOOL isLargeAndShow;

@end

@implementation HomeViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isLarge = NO;
    }
    return self;
}

-(HomeSectionModel *)configHeaderModel:(HomePageProductModel *)model{
    HomeHeaderCellModel *headerModel = [[HomeHeaderCellModel alloc] init];
    headerModel.title = @"with numerous discounts !";
    headerModel.rate = [NSString stringWithFormat:@"%@",model.camping];
    headerModel.duration = [NSString stringWithFormat:@"%@",model.thetrouble];
    headerModel.amount = [NSString stringWithFormat:@"%@%@",
                          @"₱",
                          model.supplied];
    headerModel.productId = [NSString stringWithFormat:@"%ld",model.rice];
    headerModel.buttonTitle = [NSString stringWithFormat:@"%@",model.thesage];
    kWeakSelf;
    headerModel.completion = ^(NSString *productId) {
        if ([weakSelf.deleagete respondsToSelector:@selector(onPushProductDetail:)]) {
            [weakSelf.deleagete onPushProductDetail:productId];
        }
    };
    HomeSectionModel *headerSection = [[HomeSectionModel alloc] initWith:[HomeHeaderCell class] cellData:@[headerModel]];
    return headerSection;
}

-(HomeSectionModel *)configKingKongModel{
    kWeakSelf;
    HomeKingKongItemViewModel *order = [[HomeKingKongItemViewModel alloc] initWith:HomeKingKongTypeOrder];
    order.completion = ^(HomeKingKongType type) {
        if ([weakSelf.deleagete respondsToSelector:@selector(kingKongItemClick:)]) {
            [weakSelf.deleagete kingKongItemClick:type];
        }
    };
    HomeKingKongItemViewModel *response = [[HomeKingKongItemViewModel alloc] initWith:HomeKingKongTypeResponse];
    response.completion = ^(HomeKingKongType type) {
        if ([weakSelf.deleagete respondsToSelector:@selector(kingKongItemClick:)]) {
            [weakSelf.deleagete kingKongItemClick:type];
        }
    };
    HomeKingKongItemViewModel *service = [[HomeKingKongItemViewModel alloc] initWith:HomeKingKongTypeService];
    service.completion = ^(HomeKingKongType type) {
        if ([weakSelf.deleagete respondsToSelector:@selector(kingKongItemClick:)]) {
            [weakSelf.deleagete kingKongItemClick:type];
        }
    };
    HomeKingKongCellModel *cellModel = [[HomeKingKongCellModel alloc] init];
    cellModel.items = @[order,
                        response,
                        service];
    HomeSectionModel *headerSection = [[HomeSectionModel alloc] initWith:[HomeKingKongCell class] cellData:@[cellModel]];
    return headerSection;
}

-(HomeSectionModel *)configCommonQuestionsSection{
    kWeakSelf;
    HomeCommonQuestionsCellModel *cellModel = [[HomeCommonQuestionsCellModel alloc] init];
    cellModel.completion = ^{
        if ([weakSelf.deleagete respondsToSelector:@selector(onpushCommonQuestionsView)]) {
            [weakSelf.deleagete onpushCommonQuestionsView];
        }
    };
    HomeSectionModel *sectionModel = [[HomeSectionModel alloc] initWith:[HomeCommonQuestionsCell class] cellData:@[cellModel]];
    return sectionModel;
}

-(HomeSectionModel *)configLargeSection{
    kWeakSelf;
    HomeLargeItemViewModel *model = [[HomeLargeItemViewModel alloc] initWith:@"Exclusive offers for new users!" imageName:@"icon_home_recommond" completion:^{
        if ([weakSelf.deleagete respondsToSelector:@selector(onPushProductDetail:)]) {
            [weakSelf.deleagete onPushProductDetail:@""];
        }
    }];
    HomeLargeItemViewModel *model1 = [[HomeLargeItemViewModel alloc] initWith:@"Easy operation, no worries about loans" imageName:@"icon_home_recommond1" completion:^{
        if ([weakSelf.deleagete respondsToSelector:@selector(onPushProductDetail:)]) {
            [weakSelf.deleagete onPushProductDetail:@""];
        }
    }];
    HomeLargeItemViewModel *model2 = [[HomeLargeItemViewModel alloc] initWith:@"Personalized loan solution for you" imageName:@"icon_home_recommond2" completion:^{
        if ([weakSelf.deleagete respondsToSelector:@selector(onPushProductDetail:)]) {
            [weakSelf.deleagete onPushProductDetail:@""];
        }
    }];
    HomeLargeCellModel *cellModel = [[HomeLargeCellModel alloc] initWith:@[model,
                                                                           model1,
                                                                           model2]];
    HomeSectionModel *sectionModel = [[HomeSectionModel alloc] initWith:[HomeLargeCell class] cellData:@[cellModel]];
    return sectionModel;
}

-(HomeSectionModel *)configNoticeSection:(NSArray<HomePageNoticeItemModel *> *)list{
    kWeakSelf;
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < list.count; i ++) {
        HomePageNoticeItemModel *item = list[i];
        HomeNoticeCellModel *model = [[HomeNoticeCellModel alloc] initWith:item.forbreakfast completion:^{
            if ([weakSelf.deleagete respondsToSelector:@selector(onpushOtherView:)]) {
                [weakSelf.deleagete onpushOtherView:[NSString stringWithFormat:@"%@",
                                                     item.improbable]];
            }
        }];
        [tempArray addObject:model];
    }
    HomeNoticeBannerCellModel *cellModel = [[HomeNoticeBannerCellModel alloc] init];
    cellModel.items = tempArray;
    HomeSectionModel *sectionModel = [[HomeSectionModel alloc] initWith:[HomeNoticeBannerCell class] cellData:@[cellModel]];
    return sectionModel;
}

-(HomeSectionModel *)configProductSection:(NSArray<HomePageProductModel *> *)list{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    kWeakSelf;
    for (HomePageProductModel *model in list) {
        NSString *name = [NSString stringWithFormat:@"%@",model.stew];
        NSString *rateStr = [NSString stringWithFormat:@"%@",
                             model.staunchfriend];
        NSString *durationStr = [NSString stringWithFormat:@"%@",model.plucky];
        NSString *amountStr = [NSString stringWithFormat:@"%@%@",
                               @"₱",
                               model.shrugged];
        NSString *amountDesc = [NSString stringWithFormat:@"%@",model.bring];
        NSString *productId = [NSString stringWithFormat:@"%ld",model.rice];
        HomeProductListCellModel *cellModel = [[HomeProductListCellModel alloc] initWith:name rate:rateStr duration:durationStr amount:amountStr completion:^(NSString *productId) {
            if ([weakSelf.deleagete respondsToSelector:@selector(onPushProductDetail:)]) {
                [weakSelf.deleagete onPushProductDetail:productId];
            }
        }];
        cellModel.productId = productId;
        cellModel.amountDesc = amountDesc;
        [tempArray addObject:cellModel];
    }
    HomeSectionModel *sectionModel = [[HomeSectionModel alloc] initWith:[HomeProductListCell class] cellData:tempArray];
    return sectionModel;
}

-(void)reloadData:(simpleCompletion)completion{
    kWeakSelf;
    [[HttpManager shared] requestWithService:HomePageData parameters:@{} showLoading:YES showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        weakSelf.pageModel = [HomePageModel mj_objectWithKeyValues:response.couldsee];
        [weakSelf encodeData];
        completion();
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion();
    }];
}

-(void)encodeData{
    // changedb  changedc
    if ([self.pageModel.kettle.everyonehad isEqual: @"changedb"]) {// 大卡位
        self.isLarge = YES;
        self.isLargeAndShow = (self.pageModel.finally == 1);
    }else if([self.pageModel.kettle.everyonehad isEqual: @"changedc"]){
        self.isLarge = NO;
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    if (self.pageModel.kettle.eveningmeal.firstObject) {
        HomePageProductModel *pModel = (HomePageProductModel *)self.pageModel.kettle.eveningmeal.firstObject;
        HomeSectionModel *headerModel = [self configHeaderModel:pModel];
        [tempArray addObject:headerModel];
    }
    if (self.isLarge && self.isLargeAndShow) {
        HomeSectionModel *kingKongSection = [self configKingKongModel];
        [tempArray addObject:kingKongSection];
        HomeSectionModel *questionSection = [self configCommonQuestionsSection];
        [tempArray addObject:questionSection];
        HomeSectionModel *recommondSection = [self configLargeSection];
        [tempArray addObject:recommondSection];
    }
    if (!self.isLarge) {
        if ([self.pageModel.betaken.everyonehad isEqual:@"changedd"] && self.pageModel.betaken.eveningmeal.count > 0) {
            HomeSectionModel *noticeSection = [self configNoticeSection:self.pageModel.betaken.eveningmeal];
            [tempArray addObject:noticeSection];
        }
        if ([self.pageModel.andquietly.everyonehad isEqual:@"changede"] && self.pageModel.andquietly.eveningmeal.count > 0) {
            HomeSectionModel *productSection = [self configProductSection:self.pageModel.andquietly.eveningmeal];
            [tempArray addObject:productSection];
        }
    }
    self.dataSource = tempArray;
}


-(BOOL)needLocation{
    return self.pageModel.togo == 1;
}
@end

NS_ASSUME_NONNULL_END
