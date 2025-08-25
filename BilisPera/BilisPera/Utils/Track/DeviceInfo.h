//
//  DeviceInfo.h
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DeviceFamily) {
    DeviceFamilyiPhone,
    DeviceFamilyiPod,
    DeviceFamilyiPad,
    DeviceFamilyUnknown
};

NS_ASSUME_NONNULL_BEGIN

@interface DeviceInfo : NSObject

+ (NSString *)getIdentifier;

// 设备屏幕尺寸
+ (CGFloat)deviceDiagonalSize;
+ (CGSize)deviceScreenSize;
+ (CGFloat)deviceScreenScale;

// 设备型号识别
+ (NSString *)deviceModelName;
+ (DeviceFamily)deviceFamily;
+ (BOOL)isRetinaDisplay;
+ (BOOL)isPad;

// 系统信息
+ (NSString *)systemVersion;
+ (BOOL)isSystemVersionGreaterOrEqualTo:(NSString *)version;


@end

NS_ASSUME_NONNULL_END
