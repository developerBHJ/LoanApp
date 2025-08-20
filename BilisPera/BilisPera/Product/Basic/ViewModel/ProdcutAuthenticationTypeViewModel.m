//
//  ProdcutAuthenticationTypeViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import "ProdcutAuthenticationTypeViewModel.h"
#import "ProductAuthenticationIdInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutAuthenticationTypeViewModel ()

@property (nonatomic, strong) ProductAuthenticationIdInfo *infoModel;

@end

@implementation ProdcutAuthenticationTypeViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [[NSArray alloc] init];
    }
    return self;
}

-(void)configData{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    ProductSectionModel *section = [self configTypeSection:self.infoModel.startledherd.firstObject title:@"Recommended ID Type"];
    if (section) {
        [tempArray addObject:section];
    }
    if (self.infoModel.startledherd.count > 1) {
        ProductSectionModel *section1 = [self configTypeSection:self.infoModel.startledherd[1] title:@"Other Options"];
        if (section1) {
            [tempArray addObject:section1];
        }
    }
    self.dataSource = tempArray;
}

-(ProductSectionModel *)configTypeSection:(NSArray *)list title:(NSString *)title{
    if (list.count > 0) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < list.count; i ++) {
            kWeakSelf;
            ProdcutAuthenticationItemViewModel *item = [[ProdcutAuthenticationItemViewModel alloc] initWith:list[i] needLine:(i != (list.count - 1)) completion:^(NSString * type) {
                if ([weakSelf.delegate respondsToSelector:@selector(itemSelected:)]) {
                    [weakSelf.delegate itemSelected:type];
                }
            }];
            [tempArray addObject:item];
        }
        ProdcutAuthenticationTypeCellModel *cellModel = [[ProdcutAuthenticationTypeCellModel alloc] initWith:title items:tempArray];
        ProductSectionModel *section = [[ProductSectionModel alloc] initWith:[ProdcutAuthenticationTypeCell class] cellData:@[cellModel]];
        return section;
    }
    return nil;
}

-(void)reloadData:(NSString *)productId completion:(simpleCompletion)completion{
    kWeakSelf;
    [ProdcutAuthenticationTypeViewModel queryAuthAuthenticationDetail:productId completion:^(id obj) {
        if ([obj isKindOfClass:[ProductAuthenticationIdInfo class]]) {
            weakSelf.infoModel = obj;
            [weakSelf configData];
        }
        completion();
    }];
}

+(void)queryAuthAuthenticationDetail:(NSString *)productId completion:(simpleObjectCompletion)completion{
    [[HttpManager shared] requestWithService:GetIdInfo parameters:@{@"buy":productId,@"weresoon":[NSString randomString]} showLoading:YES showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        ProductAuthenticationIdInfo *infoModel = [ProductAuthenticationIdInfo mj_objectWithKeyValues:response.couldsee];
        completion(infoModel);
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion(@"");
    }];
}

+(void)onPushAuthAuthenticationView:(NSString *)productId title:(NSString *)title type:(NSString *)type{
    [ProdcutAuthenticationTypeViewModel queryAuthAuthenticationDetail:productId completion:^(ProductAuthenticationIdInfo *model) {
        if (model.loins.building == 1 && model.whereshe == 1) {// 证件认证已完成 、人脸认证已完成
            ProdcutAuthenticationResultViewController *resultVC = [[ProdcutAuthenticationResultViewController alloc] initWith:productId title:title];
            [[UIViewController topMost].navigationController pushViewController:resultVC animated:YES];
        }else if (model.loins.building != 1){// 证件未完成
            ProdcutAuthenticationTypeViewController *typeVC = [[ProdcutAuthenticationTypeViewController alloc] initWith:productId title:title];
            [[UIViewController topMost].navigationController pushViewController:typeVC animated:YES];
        }else{
            ProdcutIdFaceIDViewController *faceIdVC = [[ProdcutIdFaceIDViewController alloc] initWith:productId title:title type:type];
            [[UIViewController topMost].navigationController pushViewController:faceIdVC animated:YES];
        }
    }];
}

@end

NS_ASSUME_NONNULL_END
