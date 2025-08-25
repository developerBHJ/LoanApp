//
//  TrackDeviceModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/6.
//

#import "TrackDeviceModel.h"
#import "DiskTools.h"
#import "BPWifiInfoHandle.h"
#import "BPADTools.h"
#import "DeviceInfo.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TrackDeviceModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _jogged = @"iOS";
        _suddenlymy = kDeviceSystemVersion;
        _huntfor = [[NSBundle mainBundle] bundleIdentifier] ?: @"";
        _level = [NSString stringWithFormat:@"%ld",[TrackTools shared].lastLoginTime];
        _higher = [self configVirulence];
        _stagnant = [self configEffectModel];
        _offinding = [self configTraceModel];
        _wolfsupping = [self configAnalystModel];
        _ahead = [self configDreamyModel];
    }
    return self;
}

-(Virulence *)configVirulence{
    Virulence *model = [[Virulence alloc] init];
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    model.adraught = (int)([UIDevice currentDevice].batteryLevel * 100);
    model.drank = [UIDevice currentDevice].batteryState == UIDeviceBatteryStateCharging ? 1 : 0;
    return model;
}

-(Effect *)configEffectModel{
    Effect *model = [[Effect alloc] init];
    return  model;
}

-(TraceModel *)configTraceModel{
    TraceModel *model = [[TraceModel alloc] init];
    model.examined = @"";
    model.sofamished = kDeviceModel;
    model.spouse = @"";
    model.isegrim = (int)kScreenH;
    model.giermund = (int)kScreenW;
    model.frau = [UIDevice currentDevice].name;
    model.schone = [UIDevice currentDevice].model;
    model.sleek = [DeviceInfo getIdentifier];
    model.gorged = [NSString stringWithFormat:@"%.2f",[DeviceInfo deviceDiagonalSize]];
    model.brute = kDeviceSystemVersion;
    return  model;
}

-(AnalystModel *)configAnalystModel{
    AnalystModel *model = [[AnalystModel alloc] init];
    model.carcase = [BPWifiInfoHandle getLocalIPAddress] ?: @"";
    model.putrid = [[NSArray alloc] init];
    if ([BPWifiInfoHandle getCurrentWifiSSid]){
        LearnModel *currentWifi = [[LearnModel alloc] init];
        currentWifi.tongues = [BPWifiInfoHandle getCurrentWifiSSid];
        currentWifi.butonly = [BPWifiInfoHandle getCurrentWifiBSid];
        currentWifi.filthy = [BPWifiInfoHandle getCurrentWifiBSid];
        currentWifi.spurred = [BPWifiInfoHandle getCurrentWifiSSid];
        model.swamp = currentWifi;
    }
    model.mewhich = model.putrid.count;
    return  model;
}

-(DreamyModel *)configDreamyModel{
    DreamyModel *model = [[DreamyModel alloc] init];
    model.sawwhat = [NSString stringWithFormat:@"%lld",[DiskTools getTotalDiskSpace]];
    model.mound = [NSString stringWithFormat:@"%lld",[DiskTools getFreeDiskSpace]];
    model.dusk = [NSString stringWithFormat:@"%lld",[DiskTools getTotalMemory]];
    model.overtaking = [NSString stringWithFormat:@"%lld",[DiskTools getAvailableMemory]];
    return  model;
}

@end

@implementation Virulence
- (instancetype)init {
    self = [super init];
    if (self) {
        _adraught = 0;
        _drank = 0;
    }
    return self;
}
@end

@implementation Effect

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fresh =  [[BPADTools shared] getIDFV];
        _nd =  [[BPADTools shared] getIDFA];
        _filthy = [BPWifiInfoHandle getCurrentWifiBSid];
        _myround = (int)[[NSDate date] timeIntervalSince1970];
        _bacteria = [BPWifiInfoHandle isProxyEnabled] ? 1 : 0;
        _feverish = [BPWifiInfoHandle isVPNConnected] ? 1: 0;
        _poorlittle = [BPWifiInfoHandle checkSymbolicLink] ? 1: 0;
        _millions = [BPWifiInfoHandle isSimulator] ? 1 : 0;
        _swarmed = @"en";
        _girths = [BPWifiInfoHandle getDefaultCarrierName] ?: @"";
        _saddle = [BPWifiInfoHandle currentNetworkTypeString] ?: @"";
        _plodded = [[NSTimeZone localTimeZone] abbreviation] ?: @"";
        _nosewouldn = [TrackTools shared].launchTime;
    }
    return self;
}

@end


@implementation TraceModel

@end

@implementation LearnModel

@end

@implementation AnalystModel

@end

@implementation DreamyModel

@end
NS_ASSUME_NONNULL_END
