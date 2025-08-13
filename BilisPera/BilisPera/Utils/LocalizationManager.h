//
//  LocalizationManager.h
//  BilisPera
//
//  Created by BHJ on 2025/8/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AppLanguage) {
    AppLanguageEN,
    AppLanguageZH,
};

@interface LocalizationManager : NSObject

+ (void)setupWithModules:(NSDictionary<NSString *, NSString *> *)modules;
+ (NSString *)stringForModule:(NSString *)module
                         key:(NSString *)key
                  defaultText:(NSString *)defaultText;
+ (void)switchLanguage:(AppLanguage)language;

@end

NS_ASSUME_NONNULL_END
