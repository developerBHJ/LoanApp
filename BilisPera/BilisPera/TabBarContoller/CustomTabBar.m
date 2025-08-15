//
//  CustomTabBar.m
//  BilisPera
//
//  Created by BHJ on 2025/8/5.
//

#import "CustomTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@implementation CustomTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

-(void)configUI{
    [self setBarTintColor:[UIColor clearColor]];
    [self setBackgroundColor:[UIColor colorWithHexString:@"#351E29"]];
    self.shadowImage = [UIImage new];
    self.backgroundImage = [UIImage new];
    self.layer.shadowColor = UIColor.blackColor.CGColor;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowRadius = 8;
    self.layer.cornerRadius = kRatio(75) / 2;
    self.clipsToBounds = NO;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView *view in self.subviews) {
        if ([view  isKindOfClass:[NSClassFromString(@"UITabBarButton") class]]) {
            for (UIView *subView in view.subviews) {
                if ([subView  isKindOfClass:[NSClassFromString(@"UITabBarButtonLabel") class]]) {
                    subView.backgroundColor = UIColor.clearColor;
                }
                if ([subView  isKindOfClass:[NSClassFromString(@"UITabBarSwappableImageView") class]]) {
                    CGRect rect = subView.frame;
                    rect.size = CGSizeMake(kRatio(32), kRatio(32));
                    subView.frame = rect;
                }
            }
        }
    }
}

@end

NS_ASSUME_NONNULL_END
