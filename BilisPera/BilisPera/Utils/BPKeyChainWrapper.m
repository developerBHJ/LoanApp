//
//  BPKeyChainWrapper.m
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import "BPKeyChainWrapper.h"
#import <Security/Security.h>

NS_ASSUME_NONNULL_BEGIN

@implementation BPKeyChainWrapper

+ (NSDictionary *)baseQueryWithKey:(NSString *)key {
    return @{
        (id)kSecClass: (id)kSecClassGenericPassword,
        (id)kSecAttrAccount: key,
        (id)kSecAttrService: [[NSBundle mainBundle] bundleIdentifier]
    };
}

+ (BOOL)saveData:(NSData *)data forKey:(NSString *)key {
    NSMutableDictionary *query = [[self baseQueryWithKey:key] mutableCopy];
    [query setObject:data forKey:(id)kSecValueData];
    
    OSStatus status = SecItemAdd((CFDictionaryRef)query, NULL);
    return status == errSecSuccess;
}

+ (nullable NSData *)loadDataForKey:(NSString *)key {
    NSMutableDictionary *query = [[self baseQueryWithKey:key] mutableCopy];
    [query setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [query setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    
    CFTypeRef result = NULL;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)query, &result);
    
    if (status != errSecSuccess) {
        return nil;
    }
    return (__bridge_transfer NSData *)result;
}

+ (BOOL)updateData:(NSData *)data forKey:(NSString *)key {
    NSDictionary *query = [self baseQueryWithKey:key];
    NSDictionary *attributes = @{(id)kSecValueData: data};
    OSStatus status = SecItemUpdate((CFDictionaryRef)query, (CFDictionaryRef)attributes);
    return status == errSecSuccess;
}

+ (BOOL)deleteDataForKey:(NSString *)key {
    NSDictionary *query = [self baseQueryWithKey:key];
    OSStatus status = SecItemDelete((CFDictionaryRef)query);
    return status == errSecSuccess;
}

@end

NS_ASSUME_NONNULL_END
