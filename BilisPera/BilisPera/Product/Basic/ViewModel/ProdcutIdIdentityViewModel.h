//
//  ProdcutIdIdentityViewModel.h
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
#import "ProdcutAuthenSectionHeaderView.h"
#import "ProdcutAuthenticationUserInfoCell.h"
#import "ProductAuthenIndetyInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProdcutIdIdentityViewDelegate <NSObject>

-(void)pickerImage;
-(void)pickerDate;


@end

@interface ProdcutIdIdentityViewModel : NSObject

@property (nonatomic, strong) ProductAuthenticationIdInfo *infoModel;
@property (nonatomic, strong) NSArray *dataSource;
-(void)reloadData:(NSString *)productId completion:(simpleCompletion)completion;
@property (nonatomic, weak) id <ProdcutIdIdentityViewDelegate> delegate;

@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger imageSource;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *birthDay;

-(void)uplodaImage:(NSString *)productId image:(UIImage *)image completion:(simpleObjectCompletion)completion;

@end

NS_ASSUME_NONNULL_END
