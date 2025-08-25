//
//  ProductBankViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import "ProductBankViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductBankViewModel ()

@property (nonatomic, strong) NSArray<ProductBankListModel *>  *listItems;
@property (nonatomic,
           strong) NSArray<ProductBankListFormModel *>  *currentArray;
@property (nonatomic,
           strong) NSMutableArray<BPProductFormEditModel *>  *editData;

@end

@implementation ProductBankViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.editData = [[NSMutableArray alloc] init];
        self.selectedType = 1;
    }
    return self;
}

-(void)configData{
    NSArray *currentArray = [[self.listItems firstWhere:^BOOL(ProductBankListModel * _Nonnull obj) {
        return obj.everyonehad == self.selectedType;
    }] bolt];
    self.currentArray = currentArray;
    if (self.currentArray.count > 0) {
        for (ProductBankListFormModel *model in self.currentArray) {
            if (model.savethe.length > 0) {
                BPProductFormEditModel *item = [[BPProductFormEditModel alloc] initWith:model.resolution value:model.savethe general:model.everyonehad];
                [self saveEditIndo:item];
            }
        }
    }
    [self updateSections];
}

-(ProductAuthenSectionModel *)configHeaderSection{
    NSString *imageName = (self.selectedType == 1) ? @"icon_auth_wallet" : @"icon_auth_bank";
    ProductAuthenticationHeaderViewModel *cellModel = [[ProductAuthenticationHeaderViewModel alloc] initWith:@"Bind wallet" subTitle:@"For information security purposes, please provide accurate and complete information." imageName:imageName];
    ProductAuthenSectionModel *section = [[ProductAuthenSectionModel alloc] initWith:[ProductAuthenticationHeaderView class] cellData:@[cellModel] sectionType:0];
    return section;
}


-(nullable ProductAuthenSectionModel *)configBankInfoSection:(NSArray<ProductBankListFormModel *> *)list{
    if (list.count == 0) {
        return nil;
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < list.count;  i ++) {
        __block ProductBankListFormModel *model = list[i];
        NSString *content = @"";
        BPProductFormEditModel *editModel = [self.editData firstWhere:^BOOL(BPProductFormEditModel *_Nonnull obj) {
            return [obj.key isEqual:model.resolution];
        }];
        if (editModel) {
            content = editModel.value ?: @"";
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
    ProductBankListCellModel *cellModel = [[ProductBankListCellModel alloc] initWith:tempArray];
    ProductAuthenSectionModel *section = [[ProductAuthenSectionModel alloc] initWith:[ProductBankListCell class] cellData:@[cellModel] sectionType:0];
    return section;
}

-(nullable ProductAuthenSectionModel *)configUserInfoSection:(NSArray<ProductBankListFormModel *> *)list{
    if (list.count == 0) {
        return nil;
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < list.count;  i ++) {
        __block ProductBankListFormModel *model = list[i];
        NSString *content = @"";
        BPProductFormEditModel *editModel = [self.editData firstWhere:^BOOL(BPProductFormEditModel *_Nonnull obj) {
            return [obj.key isEqual:model.resolution];
        }];
        if (editModel) {
            content = editModel.value ?: @"";
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
    section.headerClass = [ProdcutAuthenSectionHeaderView class];
    section.headerModel = @"Ensure that the account informations are correct ，otherwise the transfer may fail";
    section.headerHeight = kRatio(78);
    return section;
}

-(nullable ProductAuthenSectionModel *)configSegementSection{
    if (self.segementTitles.count < 1) {
        return nil;
    }
    kWeakSelf;
    ProductBankSegementCellModel *cellModel = [[ProductBankSegementCellModel alloc] initWith:self.segementTitles values:self.segementValues completion:^(NSInteger type) {
        weakSelf.selectedType = type;
        [weakSelf.editData removeAllObjects];
        [weakSelf configData];
        if (weakSelf.typeChanged) {
            weakSelf.typeChanged();
        }
    }];
    cellModel.defaultType = self.selectedType;
    ProductAuthenSectionModel *section = [[ProductAuthenSectionModel alloc] initWith:[ProductBankSegementCell class] cellData:@[cellModel]];
    return section;
}

-(void)reloadData:(NSString *)productId completion:(simpleCompletion)completion{
    if (productId.length == 0) {
        return;
    }
    kWeakSelf;
    [[HttpManager shared] requestWithService:GetBankInfo parameters:@{@"buy":productId} showLoading:YES showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        NSArray *list = response.couldsee[@"bolt"];
        if (list.count > 0) {
            weakSelf.listItems = [ProductBankListModel mj_objectArrayWithKeyValuesArray:list];
        }
        NSMutableArray *tempSegement = [[NSMutableArray alloc] init];
        NSMutableArray *tempSegementValues = [[NSMutableArray alloc] init];
        for (ProductBankListModel *model in self.listItems) {
            [tempSegement addObject:model.enclosed];
            [tempSegementValues addObject:[NSNumber numberWithInteger:model.everyonehad]];
        }
        weakSelf.segementTitles = tempSegement;
        weakSelf.segementValues = tempSegementValues;
        if (weakSelf.segementValues.count > 0) {
            weakSelf.selectedType = weakSelf.segementValues.firstObject.integerValue;
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
    ProductAuthenSectionModel *segement = [self configSegementSection];
    if (segement) {
        [tempArray addObject:segement];
    }
    if (self.currentArray.count > 0) {
        ProductAuthenSectionModel *section = [self configBankInfoSection: [self.currentArray subarrayWithRange:NSMakeRange(0,
                                                                                                                           3)]];
        if (section != nil){
            [tempArray addObject:section];
        }
        if (self.currentArray.count > 3) {
            ProductAuthenSectionModel *section1 = [self configUserInfoSection: [self.currentArray subarrayWithRange:NSMakeRange(3,
                                                                                                                                3)]];
            if (section != nil){
                [tempArray addObject:section1];
            }
        }
    }
    self.dataSource = tempArray;
}


-(void)saveUserInfoWith:(NSString *)productId completion:(simpleBoolCompletion)completion{
    if (productId.length == 0) {
        return;
    }
    NSMutableDictionary *paramas = [[NSMutableDictionary alloc] init];
    paramas[@"buy"] = productId;
    paramas[@"tender"] = @(self.selectedType);
    paramas[@"direct"] = [NSString randomString];
    for (BPProductFormEditModel *model in self.editData) {
        if (model.general.length > 0) {
            paramas[model.key] = model.general;
        }else{
            paramas[model.key] = model.value;
        }
    }
    NSLog(@"paramas = %@",paramas);
    [[HttpManager shared] requestWithService:SaveBankInfo parameters:paramas showLoading:YES showMessage:YES bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        completion(YES);
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion(NO);
    }];
}

@end


NS_ASSUME_NONNULL_END
