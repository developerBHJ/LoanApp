//
//  ProdcutAuthenticationResultViewModel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import <Foundation/Foundation.h>
#import "ProdcutAuthenticationTypeViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutAuthenticationResultViewModel : NSObject

@property (nonatomic, strong) ProductAuthenticationIdInfo *infoModel;
-(void)reloadData:(NSString *)productId completion:(simpleCompletion)completion;

@end

NS_ASSUME_NONNULL_END
