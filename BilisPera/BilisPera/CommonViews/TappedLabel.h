//
//  TappedLabel.h
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TapLabelModel : NSObject
@property (nonatomic, strong) UIColor *linkTextColor;
@property (nonatomic, strong) UIFont *linkTextFont;
@property (nonatomic, strong) UIColor *regularTextColor;
@property (nonatomic, strong) UIFont *regularTextFont;
@property (nonatomic, copy) NSString *regluarText;
@property (nonatomic, copy) NSString *linkText;
@property (nonatomic, copy) NSString *linkUrl;
@property (nonatomic, copy) void (^tapCompletion)(NSString *);

@end

@interface TappedLabel : UILabel

@property (nonatomic, strong) TapLabelModel *model;
- (instancetype)initWithFrame:(CGRect)frame model:(TapLabelModel *)model;

@end

NS_ASSUME_NONNULL_END
