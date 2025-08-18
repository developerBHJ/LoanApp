//
//  ProdcutIdFaceIDViewModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import <Foundation/Foundation.h>
#import "ProductAuthenSectionModel.h"
#import "ProductAuthenticationHeaderView.h"
#import "ProdcutAuthenticationTypeViewModel.h"
#import "ProductAuthenticationIdInfo.h"
#import "ProdcutAuthenticationIndetifyCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProdcutIdFaceIDViewDelegate <NSObject>

-(void)pickerImage;

@end

@interface ProdcutIdFaceIDViewModel : NSObject

@property (nonatomic, strong) ProductAuthenticationIdInfo *infoModel;
@property (nonatomic, strong) NSArray *dataSource;
-(void)reloadData:(NSString *)productId completion:(simpleCompletion)completion;
@property (nonatomic, weak) id <ProdcutIdFaceIDViewDelegate> delegate;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger imageSource;
@property (nonatomic, strong) UIImage *selectedImage;

-(void)uplodaImage:(NSString *)productId image:(UIImage *)image completion:(simpleBoolCompletion)completion;

@end

NS_ASSUME_NONNULL_END
