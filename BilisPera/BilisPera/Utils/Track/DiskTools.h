//
//  DiskTools.h
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import <Foundation/Foundation.h>
#import <mach/mach.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiskTools : NSObject

/// 查询未使用存储大小
+ (int64_t)getFreeDiskSpace;
/// 查询总存储大小
+ (int64_t)getTotalDiskSpace;
/// 查询总内存大小
+ (int64_t)getTotalMemory;
/// 查询未使用内存大小
+ (int64_t)getAvailableMemory;
@end

NS_ASSUME_NONNULL_END
