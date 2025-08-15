//
//  NSString+Extension.h
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

+(NSString *)randomString;
-(NSURL *)getHtmlUrl;
- (NSAttributedString *)addUnderline;
- (NSString *)safePhoneNumberWithLength:(NSInteger)lg;
- (CGFloat)getWidthWithFont:(UIFont *)font height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
