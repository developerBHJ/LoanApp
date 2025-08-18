//
//  UIImage+Extension.h
//  BilisPera
//
//  Created by BHJ on 2025/8/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

- (UIImage *)imageWithTintColor:(UIColor *)color;

-(NSData *)smartCompressWithMaxKB:(NSInteger)maxKB;


@end

NS_ASSUME_NONNULL_END
