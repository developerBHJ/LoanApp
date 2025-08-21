//
//  NSData+Extension.h
//  BilisPera
//
//  Created by BHJ on 2025/8/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (Extension)

+ (NSString *)objectToJSONString:(id)paramas;
+ (NSString *)objectToBase64JSONString:(id)paramas;

@end

NS_ASSUME_NONNULL_END
