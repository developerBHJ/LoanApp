//
//  ProductPersonalModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import "ProductPersonalModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BPProductFormModel



@end

@implementation BPProductFormEditModel

- (instancetype)initWith:(NSString *)key value:(NSString *)value general:(NSString *)general
{
    self = [super init];
    if (self) {
        self.key = key;
        self.value = value;
        self.general = general;
    }
    return self;
}

@end

@implementation ProductPersonalModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"rage" : @"BPProductFormModel"};
}

@end

NS_ASSUME_NONNULL_END
