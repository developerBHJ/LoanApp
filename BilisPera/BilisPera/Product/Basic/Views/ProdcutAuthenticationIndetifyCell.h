//
//  ProdcutAuthenticationIndetifyCell.h
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import <Foundation/Foundation.h>
#import "ProdcutAuthenticationExampleView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutAuthenticationIndetifyCellModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *cameraImage;
@property (nonatomic, assign) BOOL isFace;
@property (nonatomic, copy) simpleCompletion completion;
@property (nonatomic, strong) ProdcutAuthenticationExampleViewModel *exampleModel;

- (instancetype)initWith:(NSString *)title imageUrl:(NSString *)imageUrl image:(UIImage *)image cameraImage:(NSString *)cameraImage exampleModel:(ProdcutAuthenticationExampleViewModel *)exampleModel completion:(simpleCompletion)completion;

@end

@interface ProdcutAuthenticationIndetifyCell : BaseTableViewCell

@end

NS_ASSUME_NONNULL_END
