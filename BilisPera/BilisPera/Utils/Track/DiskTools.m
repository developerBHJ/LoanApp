//
//  DiskTools.m
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import "DiskTools.h"

NS_ASSUME_NONNULL_BEGIN

@implementation DiskTools

+ (int64_t)getFreeDiskSpace {
    NSError *error = nil;
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
        NSLog(@"获取磁盘空间失败: %@", error.localizedDescription);
        return 0;
    }
    NSNumber *freeSpace = systemAttributes[NSFileSystemFreeSize];
    return freeSpace ? [freeSpace longLongValue] : 0;
}

+ (int64_t)getTotalDiskSpace{
    NSError *error = nil;
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) {
        NSLog(@"获取磁盘空间失败: %@", error.localizedDescription);
        return 0;
    }
    NSNumber *freeSpace = systemAttributes[NSFileSystemSize];
    return freeSpace ? [freeSpace longLongValue] : 0;
}

+ (int64_t)getTotalMemory{
    vm_statistics64_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO64_COUNT;
    kern_return_t kr = host_statistics64(mach_host_self(),
                                        HOST_VM_INFO64,
                                        (host_info64_t)&vmStats,
                                        &infoCount);
    if (kr == KERN_SUCCESS) {
        uint64_t totalPages = vmStats.free_count + vmStats.active_count +
                             vmStats.inactive_count + vmStats.wire_count;
        return totalPages * (uint64_t)vm_kernel_page_size;
    }
    return 0;
}

+ (int64_t)getAvailableMemory{
    vm_statistics64_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO64_COUNT;
    
    kern_return_t kr = host_statistics64(mach_host_self(),
                                        HOST_VM_INFO64,
                                        (host_info64_t)&vmStats,
                                        &infoCount);
    
    if (kr == KERN_SUCCESS) {
        vm_size_t pageSize = vm_kernel_page_size;
        return (uint64_t)(vmStats.free_count + vmStats.inactive_count) * (uint64_t)pageSize;
    }
    return 0;
}
@end

NS_ASSUME_NONNULL_END
