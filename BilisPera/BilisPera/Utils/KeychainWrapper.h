//
//  KeychainWrapper.h
//  BilisPera
//
//  Created by BHJ on 2025/8/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeychainWrapper : NSObject
+(BOOL)saveWithKey:(NSString *)key data:(NSData *)data;
+(NSData *)loadWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
