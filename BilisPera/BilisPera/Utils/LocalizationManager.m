//
//  LocalizationManager.m
//  BilisPera
//
//  Created by BHJ on 2025/8/9.
//

#import "LocalizationManager.h"

static NSMutableDictionary *_moduleMap;
static AppLanguage _currentLanguage = AppLanguageEN;

NS_ASSUME_NONNULL_BEGIN

@implementation LocalizationManager
+ (void)initialize {
    _moduleMap = [NSMutableDictionary dictionary];
}

+ (void)setupWithModules:(NSDictionary<NSString *, NSString *> *)modules {
    [_moduleMap removeAllObjects];
    [modules enumerateKeysAndObjectsUsingBlock:^(NSString *module, NSString *fileName, BOOL *stop) {
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"strings"];
        if (path) {
            _moduleMap[module] = path;
        }
    }];
}

+ (NSString *)stringForModule:(NSString *)module
                         key:(NSString *)key
                  defaultText:(NSString *)defaultText {
    NSString *path = _moduleMap[module];
    if (!path) return defaultText;
    
    NSBundle *bundle = [NSBundle bundleWithPath:[path stringByDeletingLastPathComponent]];
    return [bundle localizedStringForKey:key value:defaultText table:nil] ?: defaultText;
}

+ (void)switchLanguage:(AppLanguage)language {
    _currentLanguage = language;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AppLanguageDidChange" object:nil];
}
@end

NS_ASSUME_NONNULL_END
