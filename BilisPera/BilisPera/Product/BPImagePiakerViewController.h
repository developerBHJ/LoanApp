//
//  BPImagePiakerViewController.h
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^pickerImageCompletion)(UIImage *image);

@interface BPImagePiakerViewController : BaseViewController

@property (nonatomic, copy) pickerImageCompletion completion;
@property (nonatomic, assign) BOOL canFlip;
- (instancetype)initWithPosition:(AVCaptureDevicePosition)position canFlip:(BOOL)canFlip;

@end

NS_ASSUME_NONNULL_END
