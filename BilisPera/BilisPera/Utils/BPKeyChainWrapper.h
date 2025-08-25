//
//  BPKeyChainWrapper.h
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKeyChainWrapper : NSObject

// 保存数据到钥匙串
+ (BOOL)saveData:(NSData *)data forKey:(NSString *)key;

// 从钥匙串读取数据
+ (nullable NSData *)loadDataForKey:(NSString *)key;

// 更新钥匙串中的数据
+ (BOOL)updateData:(NSData *)data forKey:(NSString *)key;

// 删除钥匙串中的数据
+ (BOOL)deleteDataForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
