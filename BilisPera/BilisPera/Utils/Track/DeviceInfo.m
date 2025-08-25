//
//  DeviceInfo.m
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import "DeviceInfo.h"
#import "sys/utsname.h"

NS_ASSUME_NONNULL_BEGIN

@implementation DeviceInfo

+ (NSString *)getIdentifier {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *identifier = @"";
    const char *machine = systemInfo.machine;
    for (int i = 0; machine[i] != 0; i++) {
        identifier = [identifier stringByAppendingFormat:@"%c", machine[i]];
    }
    return identifier;
}

+ (CGFloat)deviceDiagonalSize {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceModel isEqualToString:@"iPod5,1"]) return 4;
    else if ([deviceModel isEqualToString:@"iPod7,1"]) return 4;
    else if ([deviceModel isEqualToString:@"iPod9,1"]) return 4;
    else if ([deviceModel isEqualToString:@"iPhone3,1"] || [deviceModel isEqualToString:@"iPhone3,2"] || [deviceModel isEqualToString:@"iPhone3,3"]) return 3.5;
    else if ([deviceModel isEqualToString:@"iPhone4,1"]) return 3.5;
    else if ([deviceModel isEqualToString:@"iPhone5,1"] || [deviceModel isEqualToString:@"iPhone5,2"]) return 4;
    else if ([deviceModel isEqualToString:@"iPhone5,3"] || [deviceModel isEqualToString:@"iPhone5,4"]) return 4;
    else if ([deviceModel isEqualToString:@"iPhone6,1"] || [deviceModel isEqualToString:@"iPhone6,2"]) return 4;
    else if ([deviceModel isEqualToString:@"iPhone7,2"]) return 4.7;
    else if ([deviceModel isEqualToString:@"iPhone7,1"]) return 5.5;
    else if ([deviceModel isEqualToString:@"iPhone8,1"]) return 4.7;
    else if ([deviceModel isEqualToString:@"iPhone8,2"]) return 5.5;
    else if ([deviceModel isEqualToString:@"iPhone8,4"]) return 4;
    else if ([deviceModel isEqualToString:@"iPhone9,1"] || [deviceModel isEqualToString:@"iPhone9,3"]) return 4.7;
    else if ([deviceModel isEqualToString:@"iPhone9,2"] || [deviceModel isEqualToString:@"iPhone9,4"]) return 5.5;
    else if ([deviceModel isEqualToString:@"iPhone10,1"] || [deviceModel isEqualToString:@"iPhone10,4"]) return 4.7;
    else if ([deviceModel isEqualToString:@"iPhone10,2"] || [deviceModel isEqualToString:@"iPhone10,5"]) return 5.5;
    else if ([deviceModel isEqualToString:@"iPhone10,3"] || [deviceModel isEqualToString:@"iPhone10,6"]) return 5.8;
    else if ([deviceModel isEqualToString:@"iPhone11,2"]) return 5.8;
    else if ([deviceModel isEqualToString:@"iPhone11,4"] || [deviceModel isEqualToString:@"iPhone11,6"]) return 6.5;
    else if ([deviceModel isEqualToString:@"iPhone11,8"]) return 6.1;
    else if ([deviceModel isEqualToString:@"iPhone12,1"]) return 6.1;
    else if ([deviceModel isEqualToString:@"iPhone12,3"]) return 5.8;
    else if ([deviceModel isEqualToString:@"iPhone12,5"]) return 6.5;
    else if ([deviceModel isEqualToString:@"iPhone12,8"]) return 4.7;
    else if ([deviceModel isEqualToString:@"iPhone13,1"]) return 5.4;
    else if ([deviceModel isEqualToString:@"iPhone13,2"]) return 6.1;
    else if ([deviceModel isEqualToString:@"iPhone13,3"]) return 6.1;
    else if ([deviceModel isEqualToString:@"iPhone13,4"]) return 6.7;
    else if ([deviceModel isEqualToString:@"iPhone14,4"]) return 5.4;
    else if ([deviceModel isEqualToString:@"iPhone14,5"]) return 6.1;
    else if ([deviceModel isEqualToString:@"iPhone14,2"]) return 6.1;
    else if ([deviceModel isEqualToString:@"iPhone14,3"]) return 6.7;
    else if ([deviceModel isEqualToString:@"iPhone14,6"]) return 4.7;
    else if ([deviceModel isEqualToString:@"iPhone14,7"]) return 6.1;
    else if ([deviceModel isEqualToString:@"iPhone14,8"]) return 6.7;
    else if ([deviceModel isEqualToString:@"iPhone15,2"]) return 6.1;
    else if ([deviceModel isEqualToString:@"iPhone15,3"]) return 6.7;
    else if ([deviceModel isEqualToString:@"iPhone15,4"]) return 6.1;
    else if ([deviceModel isEqualToString:@"iPhone15,5"]) return 6.7;

    // iPhone 16系列（2025年）
    else if ([deviceModel isEqualToString:@"iPhone17,1"]) return 6.1;  // iPhone 16
    else if ([deviceModel isEqualToString:@"iPhone17,2"]) return 6.7;  // iPhone 16 Plus
    else if ([deviceModel isEqualToString:@"iPhone17,3"]) return 6.3;  // iPhone 16 Pro
    else if ([deviceModel isEqualToString:@"iPhone17,4"]) return 6.9;  // iPhone 16 Pro Max
    else if ([deviceModel isEqualToString:@"iPhone17,5"]) return 6.1;
    
    // 默认返回当前设备屏幕尺寸
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGFloat diagonal = sqrt(pow(screenBounds.size.width * screenScale,
                                2) + pow(screenBounds.size.height * screenScale,
                                         2)) / 163.0;
    return diagonal;
}

+ (CGSize)deviceScreenSize {
    return [[UIScreen mainScreen] bounds].size;
}

+ (CGFloat)deviceScreenScale {
    return [[UIScreen mainScreen] scale];
}

+ (NSString *)deviceModelName {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (DeviceFamily)deviceFamily {
    NSString *model = [self deviceModelName];
    if ([model containsString:@"iPhone"]) return DeviceFamilyiPhone;
    else if ([model containsString:@"iPod"]) return DeviceFamilyiPod;
    else if ([model containsString:@"iPad"]) return DeviceFamilyiPad;
    return DeviceFamilyUnknown;
}

+ (BOOL)isRetinaDisplay {
    return ([UIScreen mainScreen].scale >= 2.0);
}

+ (BOOL)isPad {
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad);
}

+ (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (BOOL)isSystemVersionGreaterOrEqualTo:(NSString *)version {
    return ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] != NSOrderedAscending);
}


@end

NS_ASSUME_NONNULL_END
