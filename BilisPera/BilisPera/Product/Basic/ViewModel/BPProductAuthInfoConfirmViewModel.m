//
//  BPProductAuthInfoConfirmViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "BPProductAuthInfoConfirmViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPProductAuthInfoConfirmViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)reloadData{
    ProductAuthenSectionModel *section = [self configUserInfoSection];
    self.dataSource = @[section];
}

-(ProductAuthenSectionModel *)configUserInfoSection{
    NSString *userName = @"";
    if (self.infoModel.tongues.length > 0) {
        userName = [NSString stringWithFormat:@"%@",
                    self.infoModel.tongues];
    }
    NSString *idNum = @"";
    if (self.infoModel.wounds.length > 0) {
        idNum = [NSString stringWithFormat:@"%@",
                 self.infoModel.wounds];
    }
    NSString *birthDay = @"";
    if (self.infoModel.alsowith.length > 0) {
        birthDay = [NSString stringWithFormat:@"%@",
                    self.infoModel.alsowith];
    }
    kWeakSelf;
    ProdcutAuthenInputViewModel *model = [[ProdcutAuthenInputViewModel alloc] initWith:BPProductFormStyleText title:@"Full Name" text:userName placeHolder:@"Please Enter" inputBgColor:kColor_FFDDE8 completion:^() {
    } valueChanged:^(NSString *value) {
        weakSelf.userName = value;
    }];
    ProdcutAuthenInputViewModel *model1 = [[ProdcutAuthenInputViewModel alloc] initWith:BPProductFormStyleText title:@"ID NO." text:idNum placeHolder:@"Please Enter" inputBgColor:kColor_FFDDE8 completion:^() {
        
    } valueChanged:^(NSString *idNumber) {
        weakSelf.idNumber = idNumber;
    }];
    ProdcutAuthenInputViewModel *model2 = [[ProdcutAuthenInputViewModel alloc] initWith:BPProductFormStyleEnum title:@"Birthday" text:birthDay placeHolder:@"Please select" inputBgColor:kColor_FFDDE8 completion:^() {
        if ([weakSelf.delegate respondsToSelector:@selector(pickerDate)]) {
            [weakSelf.delegate pickerDate];
        }
    } valueChanged:^(NSString *birthDay) {
        weakSelf.birthDay = birthDay;
    }];
    ProductAuthenSectionModel *section = [[ProductAuthenSectionModel alloc] initWith:[ProdcutAuthenticationUserInfoCell class] cellData:@[model,
                                                                                                                                          model1,
                                                                                                                                          model2] sectionType:1];
    return section;
}

@end

NS_ASSUME_NONNULL_END
