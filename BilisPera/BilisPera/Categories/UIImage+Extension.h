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

-(void)smartCompressWithMaxKB:(NSInteger)maxKB completion:(simpleObjectCompletion)completion;


@end

NS_ASSUME_NONNULL_END
