//
//  TrackDeviceModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 电池信息相关属性
@interface Virulence : BaseModel
/// 电池百分比 0~100
@property (nonatomic, assign) NSInteger adraught;
/// 是否正在充电(1:是, 0:否)
@property (nonatomic, assign) NSInteger drank;

@end

// general_data
@interface Effect : BaseModel
/// idfv
@property (nonatomic, copy) NSString *fresh;
/// idfa
@property (nonatomic, copy) NSString *nd;
/// 设备mac 取wifi里的bssid
@property (nonatomic, copy) NSString *filthy;
/// 系统当前时间(毫秒)
@property (nonatomic, assign) NSInteger myround;
/// 是否使用代理(1:是,0:否)
@property (nonatomic, assign) NSInteger bacteria;
/// 是否使用VPN(1:是,0:否)
@property (nonatomic, assign) NSInteger feverish;
/// 是否越狱
@property (nonatomic, assign) NSInteger poorlittle;
/// 是否是模拟器
@property (nonatomic, assign) NSInteger millions;
/// 设备语言
@property (nonatomic, copy) NSString *swarmed;
/// 设备运营商
@property (nonatomic, copy) NSString *girths;
/// 网络类型
@property (nonatomic, copy) NSString *saddle;
/// 时区ID
@property (nonatomic, copy) NSString *plodded;
/// 设备启动毫秒数
@property (nonatomic, assign) NSInteger nosewouldn;

@end

// hardware相关属性
@interface TraceModel : BaseModel
/// 空字符串
@property (nonatomic, copy) NSString *examined;
/// 设备品牌
@property (nonatomic, copy) NSString *sofamished;
/// 空字符串
@property (nonatomic, copy) NSString *spouse;
/// 设备高度
@property (nonatomic, assign) NSInteger isegrim;
/// 设备宽度
@property (nonatomic, assign) NSInteger giermund;
/// 设备名称
@property (nonatomic, copy) NSString *frau;
/// 设备型号
@property (nonatomic, copy) NSString *schone;
/// iPhone原始型号
@property (nonatomic, copy) NSString *sleek;
/// 物理尺寸
@property (nonatomic, copy) NSString *gorged;
/// 系统版本
@property (nonatomic, copy) NSString *brute;

@end

// 网络信息
@interface LearnModel : BaseModel
/// wifi名称
@property (nonatomic, copy) NSString *tongues;
/// bssid
@property (nonatomic, copy) NSString *butonly;
/// Mac地址
@property (nonatomic, copy) NSString *filthy;
/// ssid
@property (nonatomic, copy) NSString *spurred;

@end
// network网络模块相关属性
@interface AnalystModel : BaseModel
/// 内网ip
@property (nonatomic, copy) NSString *carcase;
/// wifi列表
@property (nonatomic, strong) NSArray<LearnModel *> *putrid;
/// 当前wifi
@property (nonatomic, strong) LearnModel *swamp;
/// wifi数量
@property (nonatomic, assign) NSInteger mewhich;

@end

// MARK: - storage内存模块相关属性
@interface DreamyModel : BaseModel
/// 未使用存储大小
@property (nonatomic, assign) NSInteger mound;
/// 总存储大小
@property (nonatomic, assign) NSInteger sawwhat;
/// 总内存大小
@property (nonatomic, assign) NSInteger dusk;
/// 未使用内存大小
@property (nonatomic, assign) NSInteger overtaking;

@end


@interface TrackDeviceModel : BaseModel

@property (nonatomic, copy) NSString *jogged; // 系统类型
@property (nonatomic, copy) NSString *suddenlymy; // 系统版本
@property (nonatomic, copy) NSString *level; // 上次登录时间(毫秒数)
@property (nonatomic, copy) NSString *huntfor; // 包名
@property (nonatomic, strong) Virulence *higher; // 电池信息
@property (nonatomic, strong) Effect *stagnant; // general_data
@property (nonatomic, strong) TraceModel *offinding; // hardware
@property (nonatomic, strong) AnalystModel *wolfsupping; // network网络模块
@property (nonatomic, strong) DreamyModel *ahead; // storage内存模块

@end

NS_ASSUME_NONNULL_END
