//
//  UITableViewAdapter.m
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import "UITableViewAdapter.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UITableViewAdapter

- (instancetype)initWith:(Class)cellType cellData:(NSArray *)cellData{
    if (self = [super init]) {
        self.cellType = cellType;
        self.cellData = cellData;
    }
    return self;
}

- (NSString *)cellId{
    return [[[self.cellType alloc] init] reuseId];
}

@end

NS_ASSUME_NONNULL_END
