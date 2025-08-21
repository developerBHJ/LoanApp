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

@property (nonatomic, strong) ProductApplyInfoModel *applyInfo;
@property (nonatomic, strong) ProductDetailModel *detailModel;
// 所有认证都已完成
@property (nonatomic, assign) BOOL isCompleted;

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

-(void)onPushDetailView:(NSString *)productId{
    kWeakSelf;
    [self apply:productId completion:^{
        if ((weakSelf.applyInfo.thecavalry == 200) && weakSelf.applyInfo.improbable.length > 0) {
            NSString *url = [NSString stringWithFormat:@"%@",
                             weakSelf.applyInfo.improbable];
            [[Routes shared] routeTo:url];
        }
    }];
}

-(void)onPushDetailHomeView:(NSString *)productId{
    kWeakSelf;
    [self queryProductDetail:productId completion:^(ProductDetailModel * _Nullable model) {
        weakSelf.detailModel = model;
        if ((weakSelf.detailModel.thecavalry != 200) && weakSelf.detailModel.improbable.length > 0) {
            NSString *url = [NSString stringWithFormat:@"%@",
                             weakSelf.detailModel.improbable];
            [[Routes shared] routeTo:url];
        }else{
            ProductHomeViewController *homeVC = [[ProductHomeViewController alloc] initWith:productId];
            [[UIViewController topMost].navigationController pushViewController:homeVC animated:YES];
        }
    }];
}

-(void)applyEvent:(NSString *)productId{
    kWeakSelf;
    [self apply:productId completion:^{
        if (weakSelf.applyInfo.improbable.length > 0) {
            [[Routes shared] routeTo:weakSelf.applyInfo.improbable];
        }
    }];
}

-(void)apply:(NSString *)productId completion:(simpleCompletion)completion{
    kWeakSelf;
    NSDictionary *paramas = @{@"buy":productId,
                              @"mules":[NSString randomString],
                              @"athand":[NSString randomString]};
    [[HttpManager shared] requestWithService:Apply parameters:paramas showLoading:YES showMessage:NO bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        weakSelf.applyInfo = [ProductApplyInfoModel mj_objectWithKeyValues:response.couldsee];
        completion();
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion();
    }];
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

// 进订单详情页
-(void)onPushOrderDetailView:(NSString *)productId completion:(simpleStringCompletion)completion{
    kWeakSelf;
    [self queryProductDetail:productId completion:^(ProductDetailModel * _Nullable model) {
        if ((model.thecavalry != 200) && model.improbable.length > 0) {
            NSString *url = [NSString stringWithFormat:@"%@",
                             weakSelf.detailModel.improbable];
            [[Routes shared] routeTo:url];
        }else{
            [weakSelf onPushDetailViewWithOrderId:[NSString stringWithFormat:@"%@",
                                                   model.rhete.andto] completion:completion];
        }
    }];
}

-(void)onPushDetailViewWithOrderId:(NSString *)orderId completion:(simpleStringCompletion)completion{
    if (orderId.length == 0) {
        return;
    }
    [[HttpManager shared] requestWithService:OrderDetail parameters:@{@"marmot": orderId,@"prairie":[NSString randomString],@"difficulties":[NSString randomString],@"thesentinels":[NSString randomString],@"brow":[NSString randomString]} showLoading:YES showMessage:YES bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        NSString *url = [NSString stringWithFormat:@"%@",
                         response.couldsee[@"improbable"]];
        completion(url);
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion(@"");
    }];
}

-(void)onPushNextStep:(NSString *)productId type:(NSString *)type{
    kWeakSelf;
    [[TrackTools shared] saveTrackTime:BPTrackRiskTypeApply start:YES];
    [self queryProductDetail:productId completion:^(ProductDetailModel * _Nullable model) {
        if (model.thecavalry != 200 && model.improbable.length > 0) {
            [[Routes shared] routeTo:model.improbable];
            [[TrackTools shared] saveTrackTime:BPTrackRiskTypeApply start:NO];
            [[TrackTools shared] trackRiskInfo:BPTrackRiskTypeApply productId:productId];
        }else if (model.packed && model.packed.trading.length > 0) {
            BPProductStep nextStep = [[ProductHandle shared] getProductStepWith:model.packed.trading];
            weakSelf.isCompleted = NO;
            [weakSelf enterNextStepViewWith:productId step:nextStep title:[NSString stringWithFormat:@"%@",
                                                                           model.packed.enclosed] type:type];
        }else{
            weakSelf.isCompleted = YES;
        }
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

-(void)saveUserInfoWithParamaters:(NSDictionary *)paramaters completion:(simpleBoolCompletion)completion{
    [[HttpManager shared] requestWithService:SaveUserInfo parameters:paramaters showLoading:YES showMessage:YES bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        completion(YES);
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

@end

NS_ASSUME_NONNULL_END
