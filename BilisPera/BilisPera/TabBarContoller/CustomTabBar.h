//
//  CustomTabBar.h
//  BilisPera
//
//  Created by BHJ on 2025/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTabBar : UIView

@property (nonatomic, assign) NSInteger defaultIndex;
- (instancetype)initWithFrame:(CGRect)frame completion:(simpleIntCompletion)completion;

@end

NS_ASSUME_NONNULL_END
