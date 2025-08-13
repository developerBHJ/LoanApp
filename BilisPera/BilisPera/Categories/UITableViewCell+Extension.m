//
//  UITableViewCell+Extension.m
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)

- (NSString *)reuseId{
    return [NSString stringWithFormat:@"reusable_%@",[self class]];
}

@end
