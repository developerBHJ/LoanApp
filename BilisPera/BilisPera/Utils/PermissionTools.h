//
//  PermissionTools.h
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef  void(^ _Nullable BPAccessCompletion)(BOOL);

static NSString *kLocationAlertMessage = @"Location permission required for identity verification. Please grant access in settings.";
static NSString *kCameraAlertMessage = @"Camera access is needed to securely capture your ID for verification.";
static NSString *kAlbumAlertMessage = @"Album permission is required to securely access your ID for verification.";
static NSString *kContactsAlertMessage = @"Bilis Pera requires that you set the contact permission to \"Full Access\" in order to verify your identity.";

@interface PermissionTools : NSObject

+ (instancetype)shared;

- (void)requestPhotoLibraryAccessWithCompletion:(BPAccessCompletion)completion;
- (void)requestCameraAccessWithCompletion:(BPAccessCompletion)completion;
- (void)requestLocationAccessWithCompletion:(BPAccessCompletion)completion;
- (void)requestContactsAccessWithCompletion:(BPAccessCompletion)completion;

@end

NS_ASSUME_NONNULL_END
