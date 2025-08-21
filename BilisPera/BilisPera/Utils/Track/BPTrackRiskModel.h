//
//  BPTrackRiskModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPTrackRiskModel : NSObject
// 产品ID  动态获取
@property (nonatomic, strong) NSString *myinexperience;
// 看文档首页 上报场景类型：1、注册 2、认证选择 3、证件信息 4、人脸照片 5、个人信息 6、工作信息 7、紧急联系人 8、银行卡信息9、开始申贷 10、结束申贷
@property (nonatomic, strong) NSString *instincts;
// 用户申贷全局订单号，不用管, 传空即可
@property (nonatomic, strong) NSString *andto;
// IDFV
@property (nonatomic, strong) NSString *superior;
// IDFA
@property (nonatomic, strong) NSString *reins;
// 经度
@property (nonatomic, strong) NSString *sighted;
// 纬度
@property (nonatomic, strong) NSString *hills;
// 开始时间
@property (nonatomic, strong) NSString *trail;
// 结束时间
@property (nonatomic, strong) NSString *neigh;
// 混淆字段
@property (nonatomic, strong) NSString *loud;

@end

NS_ASSUME_NONNULL_END
