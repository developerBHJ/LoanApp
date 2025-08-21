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

NS_ASSUME_NONNULL_BEGIN

@interface PermissionTools ()<CLLocationManagerDelegate>

@property (nonatomic, copy) BPAccessCompletion locationCompletion;
@property (nonatomic, strong) CLLocationManager *locationMannager;

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
    self.locationCompletion = completion;
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    manager.delegate = self;
    self.locationMannager = manager;
    CLAuthorizationStatus status = self.locationMannager.authorizationStatus;
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        completion(YES);
    }else{
        [self.locationMannager requestWhenInUseAuthorization];
    }
}

-(void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager{
    CLAuthorizationStatus status = manager.authorizationStatus;
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        self.locationCompletion(YES);
    }else{
        self.locationCompletion(NO);
    }
}

- (void)requestContactsAccessWithCompletion:(BPAccessCompletion)completion {
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusNotDetermined: {
            CNContactStore *store = [[CNContactStore alloc] init];
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
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
        default:
            completion(NO);
            break;
    }
}
@end

NS_ASSUME_NONNULL_END
