//
//  KeychainWrapper.m
//  BilisPera
//
//  Created by BHJ on 2025/8/6.
//

#import "KeychainWrapper.h"

NS_ASSUME_NONNULL_BEGIN

@implementation KeychainWrapper

+(BOOL)saveWithKey:(NSString *)key data:(NSData *)data{
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrAccount: key,
        (__bridge id)kSecValueData: data
    };
    SecItemDelete((__bridge CFDictionaryRef)query);
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    return status == errSecSuccess;
}

+ (NSData *)loadWithKey:(NSString *)key {
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrAccount: key,
        (__bridge id)kSecReturnData: @YES,
        (__bridge id)kSecMatchLimit: (__bridge id)kSecMatchLimitOne
    };
    CFTypeRef dataTypeRef = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &dataTypeRef);
    if (status == errSecSuccess) {
        return (__bridge_transfer NSData *)dataTypeRef;
    }
    return nil;
}

@end

NS_ASSUME_NONNULL_END
