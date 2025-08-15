//
//  HomePageModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageNoticeItemModel : BaseModel
// 显示文案，直接展示
@property (nonatomic, strong) NSString *forbreakfast;
// 跳转地址：一般是个H5的地址，直接跳转就行
@property (nonatomic, strong) NSString *improbable;

@end

@interface HomePageNoticeModel : BaseModel

@property (nonatomic, strong) NSString *everyonehad;
@property (nonatomic, strong,nullable) NSArray<HomePageNoticeItemModel *> *eveningmeal;

@end


@interface HomePageProductModel : BaseModel
// 产品ID 点击申请按钮从这拿产品ID
@property (nonatomic, assign) NSInteger rice;
// 产品名称
@property (nonatomic, strong) NSString *stew;
// 产品图片
@property (nonatomic, strong) NSString *hens;
// 大/小卡位按钮的文案
@property (nonatomic, strong) NSString *thesage;
// 贷款金额
@property (nonatomic, strong) NSString *supplied;
// 贷款金额描述文案
@property (nonatomic, strong) NSString *bring;
// 贷款期限
@property (nonatomic, strong) NSString *thetrouble;
// 贷款利率
@property (nonatomic, strong) NSString *camping;
// 贷款利率的描述文案
@property (nonatomic, strong) NSString *wasplenty;

// 贷款期限的描述文案
@property (nonatomic, strong) NSString *reasonableanswer;
// 贷款期限
@property (nonatomic, strong) NSString *plucky;
// 贷款利率
@property (nonatomic, strong) NSString *staunchfriend;
// 贷款金额
@property (nonatomic, strong) NSString *shrugged;

@end

@interface HomePageLargeModel : BaseModel

//    "everyonehad": "LARGE_CARD",   //可根据此字段判断是大卡位（首页1）还是小卡位（首页2），参照8.值映射，返回的是一个混淆后的数据
@property (nonatomic, strong) NSString *everyonehad;
@property (nonatomic, strong,nullable) NSArray<HomePageProductModel *> *eveningmeal;

@end


@interface HomePageModel : BaseModel
// 逾期信息
@property (nonatomic, strong) HomePageNoticeModel *betaken;
// 大卡位
@property (nonatomic, strong) HomePageLargeModel *kettle;
// 产品列表
@property (nonatomic, strong) HomePageLargeModel *andquietly;

// 强制定位：1强制，0不强制   当等于1时候，点击申请需要判断是否有定位权限，如果有正常跳转，如果没有，点击申请不要调用接口，只弹出提示弹窗，点击弹窗跳转系统设置，和不给相机权限效果类似
@property (nonatomic, assign) NSInteger togo;
// 首页1大卡位下面的模块    显示状态，1表示显示，0表示不显示
@property (nonatomic, assign) NSInteger finally;

@end

NS_ASSUME_NONNULL_END
