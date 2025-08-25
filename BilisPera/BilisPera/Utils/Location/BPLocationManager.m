//
//  BPLocationManager.m
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import "BPLocationManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) CLLocationManager *manager;

@end

@implementation BPLocationManager

+ (instancetype)shared {
    static BPLocationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BPLocationManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.geocoder = [[CLGeocoder alloc] init];
        self.manager = [[CLLocationManager alloc] init];
    }
    return self;
}

- (void)startLocationRequestWithCompletion:(void (^)(void))completion {
    self.manager.delegate = self;
    [self.manager startUpdatingLocation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion();
    });
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    [manager stopUpdatingLocation];
    
    BPLocationModel *model = [[BPLocationModel alloc] init];
    model.sighted = [NSString stringWithFormat:@"%f",
                     location.coordinate.latitude];
    model.hills = [NSString stringWithFormat:@"%f",
                   location.coordinate.longitude];
    
    [self saveUserLocationWithModel:model];
    [self reverseGeocodeLocationWithCoordinate:location.coordinate];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [manager stopUpdatingLocation];
}

- (void)reverseGeocodeLocationWithCoordinate:(CLLocationCoordinate2D)coordinate {
    [self.geocoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks,
                                                                                                                                                       NSError * _Nullable error) {
        if (placemarks && placemarks.count > 0) {
            CLPlacemark *place = placemarks[0];
            
            BPLocationModel *model = [self getUserLocation];
            if (!model) {
                model = [[BPLocationModel alloc] init];
            }
            model.astonishing = place.ISOcountryCode;
            model.stopped = place.country;
            model.truly = place.administrativeArea ?: (place.locality ?: @"");
            model.theplain = place.locality ?: @"";
            model.horizon = place.name ?: @"";
            [self saveUserLocationWithModel:model];
        }
    }];
}

- (BPLocationModel *)getUserLocation {
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"userLocationKey"];
    BPLocationModel *model = nil;
    if (dic) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
        if (!error) {
            model = [BPLocationModel mj_objectWithKeyValues:dic];
        } else {
            NSLog(@"转换失败: %@", error);
        }
    }
    return model;
}

- (void)saveUserLocationWithModel:(BPLocationModel *)model {
    NSDictionary *dic = model.mj_keyValues;
    if (dic) {
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"userLocationKey"];
    }
}

@end

NS_ASSUME_NONNULL_END
