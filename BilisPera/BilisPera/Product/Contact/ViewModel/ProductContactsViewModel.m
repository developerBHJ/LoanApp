//
//  ProductContactsViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import "ProductContactsViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface ProductContactsViewModel ()

@property (nonatomic, strong) NSArray<ProductContactModel *>  *listItems;
@property (nonatomic,
           strong) NSMutableArray<ProductContactEditModel *>  *editData;

@end

@implementation ProductContactsViewModel
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
        for (ProductContactModel *model in self.listItems) {
            NSString *relationship = [[model.sand firstWhereWithBlock:^BOOL(BPProductFormModel  * _Nonnull obj) {
                return [obj.everyonehad isEqual:model.tribe];
            }] tongues] ?: @"";
            if (model.tongues.length > 0) {
                [self saveUserInfoWithKey:model.prairiedogs name:model.tongues phone:model.patriarch relationKey:model.tribe relationName:relationship];
            }
        }
        ProductAuthenSectionModel *section = [self configUserInfoSection];
        [tempArray addObject:section];
    }
    self.dataSource = tempArray;
}

-(ProductAuthenSectionModel *)configHeaderSection{
    ProductAuthenticationHeaderViewModel *cellModel = [[ProductAuthenticationHeaderViewModel alloc] initWith:@"Contact Information" subTitle:@"For information security purposes, please provide accurate and complete information." imageName:@"icon_auth_personal"];
    ProductAuthenSectionModel *section = [[ProductAuthenSectionModel alloc] initWith:[ProductAuthenticationHeaderView class] cellData:@[cellModel] sectionType:0];
    return section;
}

-(ProductAuthenSectionModel *)configUserInfoSection{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.listItems.count;  i ++) {
        __block ProductContactModel *model = self.listItems[i];
        NSString *relationshipPlaceHolder = [NSString stringWithFormat:@"%@",
                                             model.suspiciously];
        NSString *namePlaceHolder = [NSString stringWithFormat:@"%@",
                                     model.forrattlesnakes];
        NSString *name = [NSString stringWithFormat:@"%@",model.tongues];
        NSString *phoneNum = [NSString stringWithFormat:@"%@",model.patriarch];
        NSString *relationship = [[model.sand firstWhereWithBlock:^BOOL(BPProductFormModel  * _Nonnull obj) {
            return [obj.everyonehad isEqual:model.tribe];
        }] tongues] ?: @"";
        ProductContactEditModel *editModel = [self.editData firstWhereWithBlock:^BOOL(ProductContactEditModel * _Nonnull obj) {
            return [obj.prairiedogs isEqual:model.prairiedogs];
        }];
        if (editModel) {
            name = editModel.tongues;
            phoneNum = editModel.patriarch;
            relationship = editModel.tongues;
            relationship = [[model.sand firstWhereWithBlock:^BOOL(BPProductFormModel * _Nonnull obj) {
                return [obj.everyonehad isEqual:editModel.tribe];
            }] tongues] ?: @"";
        }
        kWeakSelf;
        BPProductFormStyle style = BPProductFormStyleEnum;
        ProdcutAuthenInputViewModel *relationModel = [[ProdcutAuthenInputViewModel alloc] initWith:style title:model.quietlytrotted text:relationship placeHolder:relationshipPlaceHolder inputBgColor:kWhiteColor completion:^{
            if ([weakSelf.delegate respondsToSelector:@selector(showPickerView:key:options:)]) {
                [weakSelf.delegate showPickerView:model.quietlytrotted key:model.prairiedogs options:model.sand];
            }
        } valueChanged:^(NSString *value) {
        }];
        
        ProdcutAuthenInputViewModel *nameModel = [[ProdcutAuthenInputViewModel alloc] initWith:style title:model.wolves text:phoneNum placeHolder:namePlaceHolder inputBgColor:kWhiteColor completion:^{
            weakSelf.currentKey = model.prairiedogs;
            if ([weakSelf.delegate respondsToSelector:@selector(openContactsViewWith:)]) {
                [weakSelf.delegate openContactsViewWith:model.tribe];
            }
        } valueChanged:^(NSString *value) {
            
        }];
        ProductContactListCellModel *cellModel = [[ProductContactListCellModel alloc] initWithTitle:model.alarm relationModel:relationModel numberModel:nameModel];
        [tempArray addObject:cellModel];
    }
    ProductAuthenSectionModel *section = [[ProductAuthenSectionModel alloc] initWith:[ProductContactListCell class] cellData:tempArray sectionType:0];
    return section;
}

-(void)reloadData:(NSString *)productId completion:(simpleCompletion)completion{
    if (productId.length == 0) {
        return;
    }
    kWeakSelf;
    [[HttpManager shared] requestWithService:GetContactInfo parameters:@{@"buy":productId} showLoading:YES showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        NSArray *list = response.couldsee[@"majestic"][@"andwalked"];
        if (list.count > 0) {
            weakSelf.listItems = [ProductContactModel mj_objectArrayWithKeyValuesArray:list];
        }
        [weakSelf configData];
        completion();
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion();
    }];
}

- (void)saveUserInfoWithKey:(NSString *)key
                       name:(NSString *)name
                      phone:(NSString *)phone
                relationKey:(NSString *)relationKey
               relationName:(NSString *)relationName {
    if (key.length == 0) return;
    if (name.length == 0 && phone.length == 0 && relationKey.length == 0) return;
    ProductContactEditModel *item = [[ProductContactEditModel alloc] init];
    ProductContactEditModel *existingModel = [self.editData firstWhereWithBlock:^BOOL(ProductContactEditModel * _Nonnull obj) {
        return [obj.prairiedogs isEqual:key];
    }];
    if (existingModel) {
        item = existingModel;
    }
    item.prairiedogs = key;
    if (name.length > 0) {
        item.tongues = name;
    }
    
    if (phone.length > 0) {
        item.patriarch = phone;
    }
    if (relationKey.length > 0) {
        item.tribe = relationKey;
        item.relation = relationName;
    }
    NSUInteger index = [self.editData indexOfObjectPassingTest:^BOOL(ProductContactEditModel *obj,
                                                                     NSUInteger idx,
                                                                     BOOL *stop) {
        return [obj.prairiedogs isEqualToString:item.prairiedogs];
    }];
    if (index != NSNotFound) {
        NSMutableArray *tempArray = [self.editData mutableCopy];
        [tempArray replaceObjectAtIndex:index withObject:item];
        self.editData = [tempArray copy];
    } else {
        NSMutableArray *tempArray = [self.editData mutableCopy];
        [tempArray addObject:item];
        self.editData = [tempArray copy];
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
    if (productId.length == 0 || self.editData.count == 0) {
        return;
    }
    NSMutableDictionary *paramas = [[NSMutableDictionary alloc] init];
    paramas[@"buy"] = productId;
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (ProductContactEditModel *model in self.editData) {
        NSMutableDictionary *itemParamas = [[NSMutableDictionary alloc] init];
        itemParamas[@"patriarch"] = model.patriarch;
        itemParamas[@"tongues"] = model.tongues;
        itemParamas[@"tribe"] = model.tribe;
        itemParamas[@"prairiedogs"] = model.prairiedogs;
        [tempArray addObject:itemParamas];
    }
    paramas[@"couldsee"] = [NSData objectToJSONString:tempArray];
    NSLog(@"paramas = %@",paramas);
    [[HttpManager shared] requestWithService:SaveContactInfo parameters:paramas showLoading:YES showMessage:YES bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        completion(YES);
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion(NO);
    }];
}

@end

NS_ASSUME_NONNULL_END
