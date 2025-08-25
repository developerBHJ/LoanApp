//
//  BPWifiInfoHandle.m
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import "BPWifiInfoHandle.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <net/if.h>
#import <ifaddrs.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NetworkExtension.h>
#import <sys/stat.h>
#import <unistd.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <netdb.h>

NS_ASSUME_NONNULL_BEGIN

@implementation BPWifiInfoHandle


+ (BOOL)isSimulator {
    BOOL isSim = NO;
#if TARGET_OS_SIMULATOR
    isSim = YES;
#endif
    return isSim;
}

+ (NSString *)getCurrentWifiSSid {
    NSArray *interfaces = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    for (NSString *interface in interfaces) {
        NSDictionary *info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)interface);
        if (info[@"SSID"]) {
            return info[@"SSID"];
        }
    }
    return nil;
}

+ (NSString *)getCurrentWifiBSid {
    NSArray *interfaces = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    for (NSString *interface in interfaces) {
        NSDictionary *info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)interface);
        if (info[@"BSSID"]) {
            return info[@"BSSID"];
        }
    }
    return nil;
}

+ (BOOL)isProxyEnabled {
    NSDictionary *proxySettings = (__bridge NSDictionary *)CFNetworkCopySystemProxySettings();
    NSArray *proxies = (__bridge NSArray *)CFNetworkCopyProxiesForURL((__bridge CFURLRef)[NSURL URLWithString:@"https://www.baidu.com"],
                                                                      (__bridge CFDictionaryRef)proxySettings);
    if (proxies.count > 0) {
        NSDictionary *proxy = proxies[0];
        NSString *proxyType = proxy[(__bridge NSString *)kCFProxyTypeKey];
        return ![proxyType isEqualToString:(__bridge NSString *)kCFProxyTypeNone];
    }
    return NO;
}


+(BOOL)isVPNConnected {
    struct ifaddrs *interfaces = NULL;
    if (getifaddrs(&interfaces) == 0) {
        struct ifaddrs *temp = interfaces;
        while (temp != NULL) {
            if (temp->ifa_addr->sa_family == AF_INET) {
                NSString *ifname = [NSString stringWithUTF8String:temp->ifa_name];
                // 常见VPN接口前缀
                if ([ifname hasPrefix:@"utun"] || [ifname hasPrefix:@"tun"] ||
                    [ifname hasPrefix:@"ppp"] || [ifname hasPrefix:@"tap"]) {
                    freeifaddrs(interfaces);
                    return YES;
                }
            }
            temp = temp->ifa_next;
        }
        freeifaddrs(interfaces);
    }
    return NO;
}

+ (BOOL)checkSymbolicLink {
    struct stat s;
    NSString *nsString = @"/Applications";
    const char *cString = [nsString UTF8String];  // 自动处理内存和编码
    return lstat(cString, &s) == 0 && (s.st_mode & S_IFLNK) == S_IFLNK;
}

+ (NSString *)getDefaultCarrierName {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSDictionary<NSString *, CTCarrier *> *carriers = [networkInfo serviceSubscriberCellularProviders];
    CTCarrier *defaultCarrier = carriers.allValues.firstObject;
    return [self parseCarrier:defaultCarrier];
}

+ (NSString *)parseCarrier:(CTCarrier *)carrier {
    if (!carrier) return @"无SIM卡";
    NSString *carrierName = [carrier carrierName];
    if (carrierName && ![carrierName isEqualToString:@"Carrier"]) {
        return carrierName;
    }
    NSString *mcc = [carrier mobileCountryCode];
    NSString *mnc = [carrier mobileNetworkCode];
    if ([mcc isEqualToString:@"460"]) { // 中国运营商
        if ([mnc isEqualToString:@"00"] || [mnc isEqualToString:@"02"] || [mnc isEqualToString:@"07"]) {
            return @"中国移动";
        } else if ([mnc isEqualToString:@"01"] || [mnc isEqualToString:@"06"]) {
            return @"中国联通";
        } else if ([mnc isEqualToString:@"03"] || [mnc isEqualToString:@"05"] || [mnc isEqualToString:@"11"]) {
            return @"中国电信";
        }
    }
    return carrierName ?: @"未知运营商";
}

+ (BPNetworkType)currentNetworkType {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, "apple.com");
    SCNetworkReachabilityFlags flags;
    BOOL success = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    if (!success) return NetworkTypeUnknown;
        BOOL isReachable = (flags & kSCNetworkReachabilityFlagsReachable);
    BOOL needsConnection = (flags & kSCNetworkReachabilityFlagsConnectionRequired);
    
    if (!isReachable || needsConnection) {
        return NetworkTypeNotReachable;
    }
    if (flags & kSCNetworkReachabilityFlagsIsWWAN) {
        CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
        NSDictionary<NSString *, NSString *> *dic = networkInfo.serviceCurrentRadioAccessTechnology;
        NSString *radioType = [dic allValues].firstObject;
        if (@available(iOS 14.1, *)) {
            if ([radioType isEqualToString:CTRadioAccessTechnologyNRNSA] ||
                [radioType isEqualToString:CTRadioAccessTechnologyNR]) {
                return NetworkType5G;
            }
        }
        if ([radioType isEqualToString:CTRadioAccessTechnologyLTE]) {
            return NetworkType4G;
        } else if ([radioType isEqualToString:CTRadioAccessTechnologyWCDMA] ||
                  [radioType isEqualToString:CTRadioAccessTechnologyHSDPA] ||
                  [radioType isEqualToString:CTRadioAccessTechnologyHSUPA] ||
                  [radioType isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0] ||
                  [radioType isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] ||
                  [radioType isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB] ||
                  [radioType isEqualToString:CTRadioAccessTechnologyeHRPD]) {
            return NetworkType3G;
        } else if ([radioType isEqualToString:CTRadioAccessTechnologyEdge] ||
                  [radioType isEqualToString:CTRadioAccessTechnologyGPRS] ||
                  [radioType isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
            return NetworkType2G;
        }
        return NetworkTypeUnknown;
    }
    return NetworkTypeWiFi;
}

+ (NSString *)currentNetworkTypeString {
    switch ([self currentNetworkType]) {
        case NetworkTypeWiFi: return @"WiFi";
        case NetworkType2G: return @"2G";
        case NetworkType3G: return @"3G";
        case NetworkType4G: return @"4G";
        case NetworkType5G: return @"5G";
        case NetworkTypeNotReachable: return @"无网络";
        default: return @"未知网络";
    }
}


+ (NSString *)getLocalIPAddress {
    NSString *address = nil;
    struct ifaddrs *ifaddr, *firstAddr;
    if (getifaddrs(&ifaddr) != 0) {
        return nil;
    }
    firstAddr = ifaddr;
    for (struct ifaddrs *ptr = firstAddr; ptr != NULL; ptr = ptr->ifa_next) {
        if (ptr->ifa_addr->sa_family == AF_INET) {
            int flags = ptr->ifa_flags;
            if ((flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING)) {
                char hostname[NI_MAXHOST];
                if (getnameinfo(ptr->ifa_addr, sizeof(struct sockaddr_in), hostname, sizeof(hostname), NULL, 0, NI_NUMERICHOST) == 0) {
                    address = [NSString stringWithUTF8String:hostname];
                    if (![address hasPrefix:@"127."]) {
                        break;
                    }
                }
            }
        }
    }
    freeifaddrs(ifaddr);
    return address;
}

+(BOOL)isReachable{
    return [self currentNetworkType] != NetworkTypeNotReachable;
}

@end

NS_ASSUME_NONNULL_END
