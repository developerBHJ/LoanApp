//
//  PermissionTools.m
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import "PermissionTools.h"
#import "Photos/Photos.h"
#import "CoreLocation/CoreLocation.h"
#import "Contacts/Contacts.h"
#import <os/lock.h>

NS_ASSUME_NONNULL_BEGIN

@interface PermissionTools ()<CLLocationManagerDelegate>

@property (nonatomic, copy,nullable) BPAccessCompletion locationCompletion;
@property (nonatomic, strong) CLLocationManager *locationMannager;
@property (nonatomic, assign) os_unfair_lock lock;
@property (nonatomic, assign) BOOL isWaitingResponse;

@end


@implementation PermissionTools

+ (instancetype)shared {
    static PermissionTools *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PermissionTools alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}

- (void)requestPhotoLibraryAccessWithCompletion:(BPAccessCompletion)completion {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusNotDetermined: {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(status == PHAuthorizationStatusAuthorized);
                });
            }];
            break;
        }
        case PHAuthorizationStatusAuthorized:
            completion(YES);
            break;
        default:
            completion(NO);
            break;
    }
}

- (void)requestCameraAccessWithCompletion:(BPAccessCompletion)completion {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(granted);
                });
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:
            completion(YES);
            break;
        default:
            completion(NO);
            break;
    }
}

- (void)requestLocationAccessWithCompletion:(BPAccessCompletion)completion {
    os_unfair_lock_lock(&_lock);
    self.isWaitingResponse = NO;
    self.locationCompletion = completion;
    self.locationMannager = [[CLLocationManager alloc] init];
    CLAuthorizationStatus status = self.locationMannager.authorizationStatus;
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        [self completeWithStatus:status];
    }else{
        self.locationMannager.delegate = self;
        self.isWaitingResponse = YES;
        [self.locationMannager requestWhenInUseAuthorization];
    }
    os_unfair_lock_unlock(&_lock);
}

- (void)completeWithStatus:(CLAuthorizationStatus)status {
    BOOL result = NO;
    switch (status) {
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
            result = YES;
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            result = NO;
            break;
        default:
            result = NO;
    }
    
    if (self.locationCompletion) {
        self.locationCompletion(result);
        self.locationCompletion = nil;
    }
    self.isWaitingResponse = NO;
}

-(void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager{
    os_unfair_lock_lock(&_lock);
    if (self.isWaitingResponse) {
        CLAuthorizationStatus status = manager.authorizationStatus;
        [self completeWithStatus:status];
    }
    os_unfair_lock_unlock(&_lock);
}

- (void)requestContactsAccessWithCompletion:(BPAccessCompletion)completion {
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusNotDetermined: {
            CNContactStore *store = [[CNContactStore alloc] init];
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted,
                                                                                       NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(),
                               ^{
                    completion([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized);
                });
            }];
            break;
        }
        case CNAuthorizationStatusAuthorized:
            completion(YES);
            break;
        case CNAuthorizationStatusRestricted:
        case CNAuthorizationStatusDenied:
            completion(NO);
            break;
        case CNAuthorizationStatusLimited:
            completion(NO);
            break;
        default:
            completion(NO);
            break;
    }
}
@end

NS_ASSUME_NONNULL_END
