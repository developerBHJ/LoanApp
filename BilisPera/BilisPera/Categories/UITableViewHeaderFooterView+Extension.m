//
//  UITableViewHeaderFooterView+Extension.m
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import "UITableViewHeaderFooterView+Extension.h"

@implementation UITableViewHeaderFooterView (Extension)

- (NSString *)reuseId{
    return [NSString stringWithFormat:@"reusable_%@",[self class]];
}

-(void)configData:(id)data{
    
}
@end
