//
//  BPImagePiakerViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import "BPImagePiakerViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPImagePiakerViewController ()<AVCapturePhotoCaptureDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureDevice *currentCamera;
@property (nonatomic, strong) AVCapturePhotoOutput *photoOutput;

@property (nonatomic, strong) UIButton *captureButton;
@property (nonatomic, strong) UIButton *flashButton;
@property (nonatomic, strong) UIButton *flipButton;
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, assign) AVCaptureDevicePosition position;

@end

@implementation BPImagePiakerViewController

- (instancetype)initWithPosition:(AVCaptureDevicePosition)position canFlip:(BOOL)canFlip {
    self = [super init];
    if (self) {
        _position = position;
        _canFlip = canFlip;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupCamera];
}

#pragma mark - 相机配置
- (void)setupCamera {
    self.captureSession = [[AVCaptureSession alloc] init];
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera
                                                                 mediaType:AVMediaTypeVideo
                                                                  position:self.position];
    if (!device) return;
    
    self.currentCamera = device;
    
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return;
    }
    
    if ([self.captureSession canAddInput:input]) {
        [self.captureSession addInput:input];
    }
    
    self.photoOutput = [[AVCapturePhotoOutput alloc] init];
    if ([self.captureSession canAddOutput:self.photoOutput]) {
        [self.captureSession addOutput:self.photoOutput];
    }
    
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    self.previewLayer.frame = self.view.bounds;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    [self.captureSession startRunning];
}

#pragma mark - 拍照功能

- (void)capturePhoto {
    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettings];
    
    if (self.currentCamera.hasFlash) {
        settings.flashMode = self.flashButton.isSelected ? AVCaptureFlashModeOn : AVCaptureFlashModeOff;
    }
    
    [self.photoOutput capturePhotoWithSettings:settings delegate:self];
}

#pragma mark - UI设置

- (void)setupUI {
    // 拍照按钮
    self.captureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.captureButton.frame = CGRectMake(self.view.center.x - 35,
                                          self.view.bounds.size.height - 100,
                                          70, 70);
    self.captureButton.backgroundColor = [UIColor whiteColor];
    self.captureButton.layer.cornerRadius = 35;
    [self.captureButton addTarget:self
                           action:@selector(captureButtonTapped)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.captureButton];
    
    // 翻转按钮
    self.flipButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.flipButton setImage:[UIImage systemImageNamed:@"camera.rotate"] forState:UIControlStateNormal];
    self.flipButton.tintColor = [UIColor whiteColor];
    [self.flipButton addTarget:self
                        action:@selector(flipCamera)
              forControlEvents:UIControlEventTouchUpInside];
    self.flipButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.flipButton];
    
    // 返回按钮
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [[UIImage imageNamed:@"icon_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.backButton setImage:backImage forState:UIControlStateNormal];
    self.backButton.tintColor = [UIColor whiteColor];
    [self.backButton addTarget:self
                        action:@selector(backEvent)
              forControlEvents:UIControlEventTouchUpInside];
    self.backButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.backButton];
    
    // 约束
    [NSLayoutConstraint activateConstraints:@[
        // 翻转按钮约束
        [self.flipButton.centerYAnchor constraintEqualToAnchor:self.captureButton.centerYAnchor],
        [self.flipButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-kRatio(60)],
        [self.flipButton.widthAnchor constraintEqualToConstant:kRatio(44)],
        [self.flipButton.heightAnchor constraintEqualToConstant:kRatio(44)],
        
        // 返回按钮约束
        [self.backButton.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.backButton.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:kRatio(16)],
        [self.backButton.widthAnchor constraintEqualToConstant:kRatio(44)],
        [self.backButton.heightAnchor constraintEqualToConstant:kRatio(44)]
    ]];
    
    self.flipButton.hidden = !self.canFlip;
}

#pragma mark - 按钮事件

- (void)captureButtonTapped {
    [self capturePhoto];
}

- (void)flipCamera {
    [self.captureSession beginConfiguration];
    
    @try {
        AVCaptureDeviceInput *currentInput = (AVCaptureDeviceInput *)self.captureSession.inputs.firstObject;
        AVCaptureDevice *newCamera = nil;
        
        if (self.currentCamera.position == AVCaptureDevicePositionBack) {
            newCamera = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera
                                                           mediaType:AVMediaTypeVideo
                                                            position:AVCaptureDevicePositionFront];
        } else {
            newCamera = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera
                                                           mediaType:AVMediaTypeVideo
                                                            position:AVCaptureDevicePositionBack];
        }
        
        if (!newCamera) {
            [self.captureSession commitConfiguration];
            return;
        }
        
        AVCaptureDeviceInput *newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
        [self.captureSession removeInput:currentInput];
        
        if ([self.captureSession canAddInput:newInput]) {
            [self.captureSession addInput:newInput];
            self.currentCamera = newCamera;
        } else {
            [self.captureSession addInput:currentInput];
        }
    } @catch (NSException *exception) {
        NSLog(@"切换摄像头失败: %@", exception);
    } @finally {
        [self.captureSession commitConfiguration];
    }
}

- (void)backEvent {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - AVCapturePhotoCaptureDelegate

- (void)captureOutput:(AVCapturePhotoOutput *)output
didFinishProcessingPhoto:(AVCapturePhoto *)photo
                error:(nullable NSError *)error {
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return;
    }
    NSData *imageData = [photo fileDataRepresentation];
    if (!imageData) return;
    UIImage *image = [UIImage imageWithData:imageData];
    if (self.completion) {
        self.completion(image);
    }
}
@end

NS_ASSUME_NONNULL_END
