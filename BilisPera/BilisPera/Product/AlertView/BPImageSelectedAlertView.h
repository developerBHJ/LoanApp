//
//  BPImageSelectedAlertView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SelectedImageType) {
    SelectedImageTypePhoto,
    SelectedImageTypeCamera
};

@interface BPImageSelectedAlertViewModel : NSObject

@property (nonatomic, strong) NSString *leftImage;
@property (nonatomic, strong) NSString *rightImage;
@property (nonatomic, copy) simpleIntCompletion selectedCompletion;

@end

@interface BPImageSelectedAlertView : UIView

@property (nonatomic, strong) BPImageSelectedAlertViewModel *model;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame model:(BPImageSelectedAlertViewModel *)model;

@end

NS_ASSUME_NONNULL_END
