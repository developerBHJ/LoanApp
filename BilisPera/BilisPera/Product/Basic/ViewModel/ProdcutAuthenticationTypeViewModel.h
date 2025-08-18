//
//  ProdcutAuthenticationTypeViewModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import <Foundation/Foundation.h>
#import "ProductSectionModel.h"
#import "ProdcutAuthenticationTypeCell.h"
#import "ProdcutAuthenticationResultViewController.h"
#import "ProdcutAuthenticationTypeViewController.h"
#import "ProdcutIdFaceIDViewController.h"
#import "ProdcutIdIdentityViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProdcutAuthenticationTypeViewDelegate <NSObject>

-(void)itemSelected:(NSString *)type;

@end

@interface ProdcutAuthenticationTypeViewModel : NSObject

@property (nonatomic, strong) NSArray *dataSource;
+(void)onPushAuthAuthenticationView:(NSString *)productId title:(NSString *)title;
-(void)reloadData:(NSString *)productId completion:(simpleCompletion)completion;
+(void)queryAuthAuthenticationDetail:(NSString *)productId completion:(simpleObjectCompletion)completion;

@property (nonatomic, weak) id<ProdcutAuthenticationTypeViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
