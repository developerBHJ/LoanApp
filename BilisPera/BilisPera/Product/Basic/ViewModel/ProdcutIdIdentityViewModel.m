//
//  ProdcutIdIdentityViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "ProdcutIdIdentityViewModel.h"
#import "UIImage+Extension.h"

NS_ASSUME_NONNULL_BEGIN
@interface ProdcutIdIdentityViewModel ()

@end

@implementation ProdcutIdIdentityViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)configData{
    ProductAuthenSectionModel *section1 = [self configHeaderSection];
    ProductAuthenSectionModel *section2 = [self configIdentifySection];
    ProductAuthenSectionModel *section3 = [self configUserInfoSection];
    self.dataSource = @[section1,section2,section3];
}

-(ProductAuthenSectionModel *)configHeaderSection{
    ProductAuthenticationHeaderViewModel *cellModel = [[ProductAuthenticationHeaderViewModel alloc] initWith:@"Identity information" subTitle:@"After completing the certification, you can obtain the quota" imageName:@"icon_auth_idetify"];
    ProductAuthenSectionModel *section = [[ProductAuthenSectionModel alloc] initWith:[ProductAuthenticationHeaderView class] cellData:@[cellModel] sectionType:0];
    return section;
}

-(ProductAuthenSectionModel *)configIdentifySection{
    NSString *imageUrl = @"icon_auth_identify";
    if (self.infoModel.loins.building == 1 && self.infoModel.loins.improbable.length > 0) {
        imageUrl = [NSString stringWithFormat:@"%@",
                    self.infoModel.loins.improbable];
    }
    kWeakSelf;
    ProdcutAuthenticationExampleViewModel *exampleModel = [[ProdcutAuthenticationExampleViewModel alloc] initWith:@"Photo shooting requirements" items:@[@"icon_auth_example1",
                                                                                                                                                         @"icon_auth_example2",
                                                                                                                                                         @"icon_auth_example3",
                                                                                                                                                         @"icon_auth_example4"]];
    ProdcutAuthenticationIndetifyCellModel *cellModel = [[ProdcutAuthenticationIndetifyCellModel alloc] initWith:self.type imageUrl:imageUrl image:self.selectedImage cameraImage:@"icon_auth_camera" exampleModel:exampleModel completion:^{
        if ([weakSelf.delegate respondsToSelector:@selector(pickerImage)]) {
            [weakSelf.delegate pickerImage];
        }
    }];
    ProductAuthenSectionModel *section = [[ProductAuthenSectionModel alloc] initWith:[ProdcutAuthenticationIndetifyCell class] cellData:@[cellModel] sectionType:1];
    return section;
}

-(ProductAuthenSectionModel *)configUserInfoSection{
    kWeakSelf;
    ProdcutAuthenInputViewModel *model = [[ProdcutAuthenInputViewModel alloc] initWith:BPProductFormStyleText title:@"Full Name" text:self.userName placeHolder:@"Please Enter" inputBgColor:kColor_FFDDE8 completion:^() {
    } valueChanged:^(NSString *value) {
        weakSelf.userName = value;
    }];
    ProdcutAuthenInputViewModel *model1 = [[ProdcutAuthenInputViewModel alloc] initWith:BPProductFormStyleText title:@"ID NO." text:self.idNumber placeHolder:@"Please Enter" inputBgColor:kColor_FFDDE8 completion:^() {
        
    } valueChanged:^(NSString *idNumber) {
        weakSelf.idNumber = idNumber;
    }];
    ProdcutAuthenInputViewModel *model2 = [[ProdcutAuthenInputViewModel alloc] initWith:BPProductFormStyleEnum title:@"Birthday" text:self.birthDay placeHolder:@"Please select" inputBgColor:kColor_FFDDE8 completion:^() {
        if ([weakSelf.delegate respondsToSelector:@selector(pickerDate)]) {
            [weakSelf.delegate pickerDate];
        }
    } valueChanged:^(NSString *birthDay) {
        weakSelf.birthDay = birthDay;
    }];
    ProductAuthenSectionModel *section = [[ProductAuthenSectionModel alloc] initWith:[ProdcutAuthenticationUserInfoCell class] cellData:@[model,
                                                                                                                                          model1,
                                                                                                                                          model2] sectionType:1];
    section.headerClass = [ProdcutAuthenSectionHeaderView class];
    section.headerModel = @"Please confirm your identity information";
    section.headerHeight = kRatio(44);
    return section;
}


-(void)reloadData:(NSString *)productId completion:(simpleCompletion)completion{
    kWeakSelf;
    [ProdcutAuthenticationTypeViewModel queryAuthAuthenticationDetail:productId completion:^(ProductAuthenticationIdInfo *model) {
        weakSelf.infoModel = model;
        NSString *userName = @"";
        if (self.infoModel.loins.humps.tongues.length > 0) {
            userName = [NSString stringWithFormat:@"%@",
                        self.infoModel.loins.humps.tongues];
        }
        NSString *idNum = @"";
        if (self.infoModel.loins.humps.wounds.length > 0) {
            idNum = [NSString stringWithFormat:@"%@",
                     self.infoModel.loins.humps.wounds];
        }
        NSString *birthDay = @"";
        if (self.infoModel.loins.humps.alsowith.length > 0) {
            birthDay = [NSString stringWithFormat:@"%@",
                        self.infoModel.loins.humps.alsowith];
        }
        weakSelf.userName = userName;
        weakSelf.idNumber = idNum;
        weakSelf.birthDay = birthDay;
        [weakSelf configData];
        completion();
    }];
}

-(void)uplodaImage:(NSString *)productId image:(UIImage *)image completion:(simpleObjectCompletion)completion{
    [BPProressHUD showWindowesLoadingWithView:nil message:@"" autoHide:NO animated:YES];
    NSData *imageData = [UIImage compressImage:image maxSizeKB:500 maxResolution:2000];
    if (imageData) {
        [BPProressHUD hideHUDQueryHUDWithView:nil];
        [[HttpManager shared] requestWithService:UploadImage parameters:@{@"reloaded":@(self.imageSource),@"buy":productId,@"everyonehad":@(11),@"tender":self.type,@"eachshould":[NSString randomString],@"turnedagain":@"",@"hardlydared":@"1"} showLoading:YES showMessage:YES bodyBlock:^(id<AFMultipartFormData> _Nonnull formData) {
            [formData appendPartWithFileData:imageData name:@"wives" fileName:@"user_identify.jpg" mimeType:@"image/jpeg"];
        } success:^(HttpResponse * _Nonnull response) {
            ProductAuthenIndetyInfoModel *info = [ProductAuthenIndetyInfoModel mj_objectWithKeyValues:response.couldsee];
            if (info) {
                completion(info);
            }
        } failure:^(NSError * _Nonnull error,
                    NSDictionary * _Nonnull errorDictionary) {
            completion(@"");
        }];
    }
}


@end

NS_ASSUME_NONNULL_END
