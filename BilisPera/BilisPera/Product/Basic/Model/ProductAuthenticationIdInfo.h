//
//  ProductAuthenticationIdInfo.h
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductAuthenticationIdInfoDetailModel : BaseModel

// 姓名
@property (nonatomic, strong) NSString *tongues;
// 身份证
@property (nonatomic, strong) NSString *wounds;
// 生日
@property (nonatomic, strong) NSString *alsowith;

@end

@interface ProductAuthenticationDetailModel : BaseModel
// 证件是否完成 0否1是   "A"
@property (nonatomic, assign) NSInteger building;
// 证件图片地址
@property (nonatomic, strong) NSString *improbable;
// 已选卡片类型
@property (nonatomic, strong) NSString *tender;
// 证件信息
@property (nonatomic, strong) ProductAuthenticationIdInfoDetailModel *humps;

@end

@interface ProductAuthenticationIdInfo : BaseModel

@property (nonatomic, strong) ProductAuthenticationDetailModel *loins;
// 人脸是否完成 0否1是  "B"
@property (nonatomic, assign) NSInteger whereshe;
// 人脸图片地址
@property (nonatomic, strong) NSString *improbable;
// 证件类型
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *startledherd;
// 图片选择类型：1，相机+相册；2，相机
@property (nonatomic, assign) NSInteger everyonehad;


@end

NS_ASSUME_NONNULL_END
