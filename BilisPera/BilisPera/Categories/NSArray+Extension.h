//
//  NSArray+Extension.h
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Extension)

- (id)firstWhere:(BOOL (^)(id element))block;

@end

NS_ASSUME_NONNULL_END
