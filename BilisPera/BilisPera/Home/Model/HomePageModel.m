//
//  HomePageModel.m
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import "HomePageModel.h"

NS_ASSUME_NONNULL_BEGIN

@implementation HomePageNoticeItemModel

@end

@implementation HomePageNoticeModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"eveningmeal" :@"HomePageNoticeItemModel"};
}

@end

@implementation HomePageProductModel : BaseModel

- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key{
    
}

@end

@implementation HomePageLargeModel : BaseModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"eveningmeal" :@"HomePageProductModel"};
}

@end

@implementation HomePageModel

@end

NS_ASSUME_NONNULL_END
