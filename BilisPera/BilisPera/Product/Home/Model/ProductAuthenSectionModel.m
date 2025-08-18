//
//  ProductAuthenSectionModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "ProductAuthenSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ProductAuthenSectionModel

- (instancetype)initWith:(Class)cellType cellData:(NSArray *)cellData sectionType:(NSInteger)sectionType{
    if (self = [super initWith:cellType cellData:cellData]) {
        self.sectionType = sectionType;
    }
    return self;
}

- (NSString *)headerId{
    return [[[self.headerClass alloc] init] reuseId];
}

@end

NS_ASSUME_NONNULL_END
