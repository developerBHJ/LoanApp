//
//  NSArray+Extension.m
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

- (id)firstWhere:(BOOL (^)(id element))block {
    if (!block) return nil;
    for (id element in self) {
        if (block(element)) {
            return element;
        }
    }
    return nil;
}

@end
