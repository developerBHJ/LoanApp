//
//  ProductHandle.h
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductHandle : NSObject

+ (instancetype)shared;
-(void)onPushDetailView:(NSString *)productId;

@end

NS_ASSUME_NONNULL_END
