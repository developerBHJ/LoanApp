//
//  BPSettingViewModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import "BPSettingViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPSettingViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configData];
    }
    return self;
}

-(void)configData{
    MineListCellModel *model = [[MineListCellModel alloc] initWith:BPMineListVersion];
    MineListCellModel *model1 = [[MineListCellModel alloc] initWith:BPMineListLogOut];
    MineSectionModel *setion = [[MineSectionModel alloc] initWith:[BPSettingListCell class] cellData:@[model,
                                                                                                       model1]];
    self.dataSource = @[setion];
}

-(void)logOut:(simpleBoolCompletion)completion{
    [[HttpManager shared] requestWithService:UserLogOut parameters:@{@"nearlyempty": [NSString randomString],@"mornings":[NSString randomString]} showLoading:YES showMessage:YES bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        completion(YES);
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion(NO);
    }];
}

-(void)logOff:(simpleBoolCompletion)completion{
    [[HttpManager shared] requestWithService:UserLogOut parameters:@{@"itselfout":[NSString randomString]} showLoading:YES showMessage:YES bodyBlock:nil success:^(HttpResponse * _Nonnull response) {
        completion(YES);
    } failure:^(NSError * _Nonnull error,
                NSDictionary * _Nonnull errorDictionary) {
        completion(NO);
    }];
}

@end

NS_ASSUME_NONNULL_END
