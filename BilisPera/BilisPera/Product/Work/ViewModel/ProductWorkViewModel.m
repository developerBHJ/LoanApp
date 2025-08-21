//
//  ProductWorkViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import "ProductWorkViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductWorkViewModel ()

@property (nonatomic, strong) NSArray<ProductPersonalModel *>  *listItems;
@property (nonatomic,
           strong) NSMutableArray<BPProductFormEditModel *>  *editData;

@end

@implementation ProductWorkViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.editData = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)configData{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    ProductAuthenSectionModel *header = [self configHeaderSection];
    [tempArray addObject:header];
    if (self.listItems.count > 0) {
        for (ProductPersonalModel *model in self.listItems) {
            if (model.savethe.length > 0) {
                BPProductFormEditModel *item = [[BPProductFormEditModel alloc] initWith:model.resolution value:model.savethe general:model.everyonehad];
                [self saveEditIndo:item];
            }
        }
        ProductAuthenSectionModel *section = [self configUserInfoSection];
        [tempArray addObject:section];
    }
    self.dataSource = tempArray;
}

-(ProductAuthenSectionModel *)configHeaderSection{
    ProductAuthenticationHeaderViewModel *cellModel = [[ProductAuthenticationHeaderViewModel alloc] initWith:@"Work Information" subTitle:@"For information security purposes, please provide accurate and complete information." imageName:@"icon_auth_personal"];
    ProductAuthenSectionModel *section = [[ProductAuthenSectionModel alloc] initWith:[ProductAuthenticationHeaderView class] cellData:@[cellModel] sectionType:0];
    return section;
}

-(ProductAuthenSectionModel *)configUserInfoSection{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.listItems.count;  i ++) {
        __block ProductPersonalModel *model = self.listItems[i];
        NSString *content = @"";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key == %@",
                                  model.resolution];
        NSArray *filteredArray = [self.editData filteredArrayUsingPredicate:predicate];
        if (filteredArray.count > 0) {
            BPProductFormEditModel *item = [filteredArray firstObject];
            if (item) {
                content = item.value ?: @"";
            }
        }
        kWeakSelf;
        BPProductFormStyle style = [[ProductHandle shared] getProductFormStyleWith:model.hiding];
        UIKeyboardType keyboardType = (model.toour == 1) ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault;
        ProdcutAuthenInputViewModel *viewModel = [[ProdcutAuthenInputViewModel alloc] initWith:style title:model.enclosed text:content placeHolder:model.compound inputBgColor:kWhiteColor completion:^{
            if ([weakSelf.delegate respondsToSelector:@selector(showPickerView:title:values:isAddress:)]) {
                [weakSelf.delegate showPickerView:model.resolution title:model.compound values:model.rage isAddress:style == BPProductFormStyleCitySelected];
            }
        } valueChanged:^(NSString *value) {
            BPProductFormEditModel *item = [[BPProductFormEditModel alloc] initWith:model.resolution value:value general:@""];
            [weakSelf saveEditIndo:item];
        }];
        viewModel.keyboardType = keyboardType;
        [tempArray addObject:viewModel];
    }
    ProductAuthenSectionModel *section = [[ProductAuthenSectionModel alloc] initWith:[ProdcutAuthenInputCell class] cellData:tempArray sectionType:0];
    return section;
}

-(void)reloadData:(NSString *)productId completion:(simpleCompletion)completion{
    if (productId.length == 0) {
        return;
    }
    kWeakSelf;
    [[HttpManager shared] requestWithService:GetUserWorkInfo parameters:@{@"buy":productId} showLoading:YES showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        NSArray *list = response.couldsee[@"bolt"];
        if (list.count > 0) {
            weakSelf.listItems = [ProductPersonalModel mj_objectArrayWithKeyValuesArray:list];
        }
        [weakSelf configData];
        completion();
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion();
    }];
}

-(void)saveEditIndo:(BPProductFormEditModel *)item{
    if (item.key.length == 0) {
        return;
    }
    if (item.value.length == 0) {
        // 查找并删除空值项
        NSInteger index = [self.editData indexOfObjectPassingTest:^BOOL(BPProductFormEditModel *obj,
                                                                        NSUInteger idx,
                                                                        BOOL *stop) {
            return [obj.key isEqualToString:item.key];
        }];
        if (index != NSNotFound) {
            [self.editData removeObjectAtIndex:index];
        }
    } else {
        // 查找并更新或添加项
        NSInteger index = [self.editData indexOfObjectPassingTest:^BOOL(BPProductFormEditModel *obj,
                                                                        NSUInteger idx,
                                                                        BOOL *stop) {
            return [obj.key isEqualToString:item.key];
        }];
        if (index != NSNotFound) {
            [self.editData replaceObjectAtIndex:index withObject:item];
        } else {
            [self.editData addObject:item];
        }
    }
}

-(void)updateSections{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    ProductAuthenSectionModel *header = [self configHeaderSection];
    [tempArray addObject:header];
    if (self.listItems.count > 0) {
        ProductAuthenSectionModel *section = [self configUserInfoSection];
        [tempArray addObject:section];
    }
    self.dataSource = tempArray;
}


-(void)saveUserInfoWith:(NSString *)productId completion:(simpleBoolCompletion)completion{
    if (productId.length == 0) {
        return;
    }
    NSMutableDictionary *paramas = [[NSMutableDictionary alloc] init];
    paramas[@"buy"] = productId;
    for (BPProductFormEditModel *model in self.editData) {
        if (model.general.length > 0) {
            paramas[model.key] = model.general;
        }else{
            paramas[model.key] = model.value;
        }
    }
    NSLog(@"paramas = %@",paramas);
    [[HttpManager shared] requestWithService:SaveUserWorkInfo parameters:paramas showLoading:YES showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        completion(YES);
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion(NO);
    }];
}

@end

NS_ASSUME_NONNULL_END
