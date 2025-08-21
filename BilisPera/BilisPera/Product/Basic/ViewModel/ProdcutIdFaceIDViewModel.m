//
//  ProdcutIdFaceIDViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "ProdcutIdFaceIDViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProdcutIdFaceIDViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageSource = 2;
    }
    return self;
}

-(void)configData{
    ProductAuthenSectionModel *section1 = [self configHeaderSection];
    ProductAuthenSectionModel *section2 = [self configIdentifySection];
    self.dataSource = @[section1,section2];
}

-(ProductAuthenSectionModel *)configHeaderSection{
    ProductAuthenticationHeaderViewModel *cellModel = [[ProductAuthenticationHeaderViewModel alloc] initWith:@"Face Recognition" subTitle:@"Photo is only used for real name authentication" imageName:@"icon_auth_idetify"];
    ProductAuthenSectionModel *section = [[ProductAuthenSectionModel alloc] initWith:[ProductAuthenticationHeaderView class] cellData:@[cellModel] sectionType:0];
    return section;
}

-(ProductAuthenSectionModel *)configIdentifySection{
    NSString *imageUrl = @"icon_auth_identify";
    if (self.infoModel.whereshe == 1 && self.infoModel.improbable.length > 0) {
        imageUrl = [NSString stringWithFormat:@"%@",
                    self.infoModel.improbable];
    }
    kWeakSelf;
    ProdcutAuthenticationExampleViewModel *exampleModel = [[ProdcutAuthenticationExampleViewModel alloc] initWith:@"Face recognition requirements" items:@[@"icon_face_example1",
                                                                                                                                                           @"icon_face_example2",
                                                                                                                                                           @"icon_face_example3",
                                                                                                                                                           @"icon_face_example4"]];
    ProdcutAuthenticationIndetifyCellModel *cellModel = [[ProdcutAuthenticationIndetifyCellModel alloc] initWith:@"Face recognition" imageUrl:imageUrl image:self.selectedImage cameraImage:@"icon_auth_face"  exampleModel:exampleModel completion:^{
        if ([weakSelf.delegate respondsToSelector:@selector(pickerImage)]) {
            [weakSelf.delegate pickerImage];
        }
    }];
    cellModel.isFace = YES;
    ProductAuthenSectionModel *section = [[ProductAuthenSectionModel alloc] initWith:[ProdcutAuthenticationIndetifyCell class] cellData:@[cellModel] sectionType:1];
    return section;
}

-(void)reloadData:(NSString *)productId completion:(simpleCompletion)completion{
    kWeakSelf;
    [ProdcutAuthenticationTypeViewModel queryAuthAuthenticationDetail:productId completion:^(ProductAuthenticationIdInfo *model) {
        weakSelf.infoModel = model;
        [weakSelf configData];
        completion();
    }];
}

-(void)uplodaImage:(NSString *)productId image:(UIImage *)image completion:(simpleBoolCompletion)completion{
    [BPProressHUD showWindowesLoadingWithView:nil message:@"" autoHide:NO animated:YES];
    NSData *imageData = [UIImage compressWithImage:image maxSizeKB:500 maxResolution:2000];
    if (imageData) {
        [BPProressHUD hideHUDQueryHUDWithView:nil];
        [[HttpManager shared] requestWithService:UploadImage parameters:@{@"reloaded":@(self.imageSource),@"buy":productId,@"everyonehad":@(10),@"tender":self.type,@"eachshould":[NSString randomString],@"turnedagain":@"",@"hardlydared":@"1"} showLoading:YES showMessage:YES bodyBlock:^(id<AFMultipartFormData> _Nonnull formData) {
            NSString *imageName = [NSString stringWithFormat:@"%@%@%@",@"user_identify",[NSString randomString],@".jpg"];
            [formData appendPartWithFileData:imageData name:@"wives" fileName:imageName mimeType:@"image/jpeg"];
        } success:^(HttpResponse * _Nonnull response) {
            completion(YES);
        } failure:^(NSError * _Nonnull error,
                    NSDictionary * _Nonnull errorDictionary) {
            completion(NO);
        }];
    }
}

@end

NS_ASSUME_NONNULL_END
