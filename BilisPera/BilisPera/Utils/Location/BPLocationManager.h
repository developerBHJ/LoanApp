//
//  BPLocationManager.h
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import <Foundation/Foundation.h>
#import "BPLocationModel.h"
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPLocationManager : NSObject

+ (instancetype)shared;
- (void)startLocationRequestWithCompletion:(void (^)(void))completion;
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations;
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
- (void)reverseGeocodeLocationWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (BPLocationModel *)getUserLocation;
- (void)saveUserLocationWithModel:(BPLocationModel *)model;

@end

NS_ASSUME_NONNULL_END
