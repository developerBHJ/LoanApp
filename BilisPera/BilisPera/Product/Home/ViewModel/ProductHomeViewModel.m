//
//  ProductHomeViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/15.
//

#import "ProductHomeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductHomeViewModel ()
@property (nonatomic, strong) ProductDetailModel *detailModel;

@end

@implementation ProductHomeViewModel

- (instancetype)initWith:(NSString *)productId orderId:(NSString *)orderId
{
    self = [super init];
    if (self) {
        self.productId = productId;
        [self configData];
    }
    return self;
}

-(ProductSectionModel *)configHeaderSection{
    ProductHomeHeaderViewModel *cellModel = [[ProductHomeHeaderViewModel alloc] init];
    cellModel.name = [NSString stringWithFormat:@"%@",
                      self.detailModel.rhete.stew];
    cellModel.productId = [NSString stringWithFormat:@"%@",
                           self.detailModel.rhete.rice];
    cellModel.amount = [NSString stringWithFormat:@"%@%@",
                        @"₱",
                        self.detailModel.rhete.officers];
    cellModel.amountDesc = [NSString stringWithFormat:@"%@",
                            self.detailModel.rhete.canvas];
    cellModel.imageUrl = @"";
    cellModel.rightImageName = [NSString stringWithFormat:@"%@",
                                self.detailModel.rhete.complaintUrl];
    ProductSectionModel *section = [[ProductSectionModel alloc] initWith:[ProductHomeHeaderView class] cellData:@[cellModel]];
    return section;
}

-(ProductSectionModel *)configStepSection{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSInteger progres = 0;
    for (int i = 0; i < self.detailModel.palisade.count; i ++) {
        ProductDetailStepModel *stepModel = self.detailModel.palisade[i];
        if (stepModel.building == 1) {
            progres += 1;
        }
        kWeakSelf;
        __block ProductStepBannerItemViewModel *itemModel = [[ProductStepBannerItemViewModel alloc] initWith:[[ProductHandle shared] getProductStepWith:stepModel.trading] finished:(stepModel.building == 1) completion:^(NSInteger step) {
            if (stepModel.building == 1) {
                [[ProductHandle shared] enterNextStepViewWith:weakSelf.productId step:step title:stepModel.enclosed type:@""];
            }else{
                [[ProductHandle shared] enterAuthenView:weakSelf.productId type:@""];
            }
        }];
        [tempArray addObject:itemModel];
    }
    ProductHomeStepCellModel *cellModel = [[ProductHomeStepCellModel alloc] init];
    cellModel.stepArray = tempArray;
    cellModel.title = @"Complete The Identity Verification";
    cellModel.imageName = @"";
    cellModel.buttonTitle = @"Go for certification";
    cellModel.progress = progres;
    ProductSectionModel *section = [[ProductSectionModel alloc] initWith:[ProductHomeStepCell class] cellData:@[cellModel]];
    return section;
}

-(void)configData{
    ProductSectionModel *headerSection = [self configHeaderSection];
    ProductSectionModel *stepSection = [self configStepSection];
    self.dataSource = @[headerSection,stepSection];
}

-(void)reloadDataWithProductId:(NSString *)productId completion:(simpleCompletion)completion{
    kWeakSelf;
    [[ProductHandle shared] queryProductDetail:productId completion:^(ProductDetailModel * _Nullable model) {
        weakSelf.detailModel = model;
        [weakSelf configData];
        completion();
    }];
}

@end

NS_ASSUME_NONNULL_END
