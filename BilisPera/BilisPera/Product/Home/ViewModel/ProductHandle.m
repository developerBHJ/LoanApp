//
//  ProductHandle.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "ProductHandle.h"
#import "ProductHomeViewController.h"
#import "ProductApplyInfoModel.h"
#import "ProdcutAuthenticationTypeViewModel.h"
#import "ProductWorkViewController.h"
#import "ProductBankViewController.h"
#import "ProductPersonalViewController.h"
#import "ProductContactsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductHandle ()

@property (nonatomic, strong) ProductDetailModel *detailModel;
// 所有认证都已完成
@property (nonatomic, assign) BOOL isCompleted;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *nextTitle;
@property (nonatomic, strong) NSString *productId;

@end

@implementation ProductHandle
+ (instancetype)shared {
    static ProductHandle *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[ProductHandle alloc] init];
    });
    return _shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.needLocation = NO;
    }
    return self;
}

- (BPProductStep)getProductStepWith:(NSString *)step{
    BPProductStep temp = BPProductStepFaceId;
    if ([step isEqualToString:@"changedf"]) {
        temp = BPProductStepFaceId;
    }else if([step isEqualToString:@"changedg"]){
        temp = BPProductStepBasic;
    }else if([step isEqualToString:@"changedh"]){
        temp = BPProductStepWork;
    }else if([step isEqualToString:@"changedi"]){
        temp = BPProductStepContact;
    }else if([step isEqualToString:@"changedj"]){
        temp = BPProductStepBank;
    }
    return temp;
}

- (BPProductFormStyle)getProductFormStyleWith:(NSString *)style{
    BPProductFormStyle temp = BPProductFormStyleEnum;
    if ([style isEqualToString:@"changedk"]) {
        temp = BPProductFormStyleEnum;
    }else if([style isEqualToString:@"changedl"]){
        temp = BPProductFormStyleText;
    }else if([style isEqualToString:@"changedm"]){
        temp = BPProductFormStyleCitySelected;
    }
    return temp;
}

-(void)queryProductDetail:(NSString *)productId completion:(productDetailList)completion{
    NSDictionary *paramas = @{@"buy":productId,
                              @"pitched":[NSString randomString],
                              @"usefulto":[NSString randomString]};
    [[HttpManager shared] requestWithService:ProductDetail parameters:paramas showLoading:YES showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        ProductDetailModel *detailModel = [ProductDetailModel mj_objectWithKeyValues:response.couldsee];
        completion(detailModel);
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion(nil);
    }];
}

-(void)saveUserInfoWithParamaters:(NSDictionary *)paramaters completion:(simpleBoolCompletion)completion{
    [[HttpManager shared] requestWithService:SaveUserInfo parameters:paramaters showLoading:YES showMessage:YES bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        if (response.resolution == 0) {
            completion(YES);
        }
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion(NO);
    }];
}

-(void)requestAddressList{
    kWeakSelf;
    [[HttpManager shared] requestWithService:GetUserAddress parameters:@{} showLoading:NO showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        NSArray *list = response.couldsee[@"andwalked"];
        if (list) {
            weakSelf.addressList = [BPAddressModel mj_objectArrayWithKeyValuesArray:list];
        }
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
            
    }];
}

-(void)onPushProductHomeView:(NSString *)productId{
    if (productId.length > 0) {
        self.productId = productId;
    }
    [self requestNextStep:productId completion:^(id obj) {
        if ([obj isKindOfClass:[ProductDetailModel class]]) {
            ProductDetailModel *model = (ProductDetailModel *)obj;
            if (model.thecavalry != 200 && model.improbable.length > 0) {
                NSString *url = [NSString stringWithFormat:@"%@",
                                 model.improbable];
                [[Routes shared] routeTo:url];
            }else{
                ProductHomeViewController *homeVC = [[ProductHomeViewController alloc] initWith:productId];
                [[UIViewController topMost].navigationController pushViewController:homeVC animated:YES];
            }
        }
    }];
}

-(void)requestNextStep:(NSString *)productId completion:(simpleObjectCompletion)completion{
    if (productId.length == 0) {
        completion(@"");
        return;
    }
    kWeakSelf;
    [self queryProductDetail:productId completion:^(ProductDetailModel * _Nullable model) {
        if (model.rhete.andto.length > 0) {
            weakSelf.orderId = model.rhete.andto;
        }
        if (model.packed.enclosed.length > 0) {
            weakSelf.nextTitle = model.packed.enclosed;
        }
        completion(model);
    }];
}

-(void)requestNextStepWithOrderId:(NSString *)orderId completion:(simpleStringCompletion)completion{
    if (orderId.length == 0) {
        completion(@"");
        return;
    }
    kWeakSelf;
    [[TrackTools shared] saveTrackTime:BPTrackRiskTypeApply start:YES];
    [[HttpManager shared] requestWithService:OrderDetail parameters:@{@"marmot": orderId,@"prairie":[NSString randomString],@"difficulties":[NSString randomString],@"thesentinels":[NSString randomString],@"brow":[NSString randomString]} showLoading:YES showMessage:YES bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        NSString *url = [NSString stringWithFormat:@"%@",
                         response.couldsee[@"improbable"]];
        if (url.length > 0) {
            [[TrackTools shared] saveTrackTime:BPTrackRiskTypeApply start:NO];
            [[TrackTools shared]trackRiskInfo:BPTrackRiskTypeApply productId: weakSelf.productId];
            completion(url);
        }else{
            completion(@"");
        }
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion(@"");
    }];
}

-(void)enterAuthenView:(NSString *)productId type:(NSString *)type{
    if (productId.length > 0) {
        self.productId = productId;
    }
    kWeakSelf;
    [self requestNextStep:productId completion:^(id obj) {
        if ([obj isKindOfClass:[ProductDetailModel class]]) {
            ProductDetailModel *model = (ProductDetailModel *)obj;
            if (model.packed) {
                weakSelf.nextTitle = model.packed.enclosed;
                BPProductStep step = [[ProductHandle shared] getProductStepWith:model.packed.trading];
                [weakSelf enterNextStepViewWith:productId step:step title:weakSelf.nextTitle type:type];
            }else {
                [self requestNextStepWithOrderId:self.orderId completion:^(NSString *url) {
                    if (url.length > 0) {
                        [[Routes shared] routeTo:url];
                    }
                }];
            }
        }
    }];
}

-(void)apply:(NSString *)productId{
    if (productId.length > 0) {
        self.productId = productId;
    }
    NSDictionary *paramas = @{@"buy":productId,
                              @"mules":[NSString randomString],
                              @"athand":[NSString randomString]};
    [[HttpManager shared] requestWithService:Apply parameters:paramas showLoading:YES showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        ProductApplyInfoModel *applyInfo = [ProductApplyInfoModel mj_objectWithKeyValues:response.couldsee];
        if (applyInfo.improbable.length > 0) {
            [[Routes shared] routeTo:applyInfo.improbable];
        }
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
    }];
}

-(void)enterNextStepViewWith:(NSString *)productId step:(BPProductStep)step title:(NSString *)title type:(NSString *)type{
    if (step == BPProductStepFaceId ) {
        [ProdcutAuthenticationTypeViewModel onPushAuthAuthenticationView:productId title:title type:type];
    }else if (step == BPProductStepBasic){
        ProductPersonalViewController *personalVC = [[ProductPersonalViewController alloc] initWith:productId title:title];
        [[UIViewController topMost].navigationController pushViewController:personalVC animated:YES];
    }else if (step == BPProductStepWork){
        ProductWorkViewController *workVC = [[ProductWorkViewController alloc] initWith:productId title:title];
        [[UIViewController topMost].navigationController pushViewController:workVC animated:YES];
    }else if (step == BPProductStepContact){
        ProductContactsViewController *contactsVC = [[ProductContactsViewController alloc] initWith:productId title:title];
        [[UIViewController topMost].navigationController pushViewController:contactsVC animated:YES];
    }else if (step == BPProductStepBank){
        ProductBankViewController *bankVC = [[ProductBankViewController alloc] initWith:productId title:title];
        [[UIViewController topMost].navigationController pushViewController:bankVC animated:YES];
    }
}


-(void)checkAuthCompleted:(simpleBoolCompletion)completion{
    [self queryProductDetail:self.productId completion:^(ProductDetailModel * _Nullable model) {
        if (model.packed) {
            completion(NO);
        }else{
            completion(YES);
        }
    }];
}
@end

NS_ASSUME_NONNULL_END
