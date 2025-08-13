//
//  NSDictionary+Extension.m
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

-(NSString *)toURLStrings{
    NSURLComponents *componets = [[NSURLComponents alloc] init];
    NSMutableArray *queryItems = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:[NSString stringWithFormat:@"%@",key] value:[NSString stringWithFormat:@"%@",obj]]];
    }];
    componets.queryItems = queryItems;
    return componets.percentEncodedQuery ?: @"";
}


@end
