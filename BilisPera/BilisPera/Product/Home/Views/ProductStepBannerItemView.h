//
//  ProductStepBannerItemView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductStepBannerItemViewModel : NSObject

@property (nonatomic, assign) BPProductStep step;
@property (nonatomic, strong,readonly) NSString *title;
@property (nonatomic, strong,readonly) NSString *content;
@property (nonatomic, strong,readonly) NSString *imageName;
@property (nonatomic, strong,readonly) NSString *selectedImageName;
@property (nonatomic, assign) BOOL finished;
@property (nonatomic, copy) simpleIntCompletion completion;

- (instancetype)initWith:(BPProductStep)step finished:(BOOL)finished completion:(simpleIntCompletion)completion;

@end

@interface ProductStepBannerItemView : UICollectionViewCell

@property (nonatomic, strong) ProductStepBannerItemViewModel *model;

@end

NS_ASSUME_NONNULL_END
