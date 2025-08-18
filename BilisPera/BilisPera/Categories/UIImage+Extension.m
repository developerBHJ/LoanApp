//
//  UIImage+Extension.m
//  BilisPera
//
//  Created by BHJ on 2025/8/15.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (UIImage *)imageWithTintColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


-(NSData *)smartCompressWithMaxKB:(NSInteger)maxKB{
    NSInteger maxLength = maxKB * 1024;
    CGFloat compression = 1.0;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (!data) return nil;
    if (data.length < maxLength) {
        return data;
    }
    CGFloat max = 1.0;
    CGFloat min = 0.0;
    for (int i = 0; i < 6; i++) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if ((CGFloat)data.length < (CGFloat)maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    return data;
}
@end
