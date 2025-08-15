//
//  BPEmptyView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPEmptyView : UIView

- (instancetype)initWithFrame:(CGRect)frame emptyImage:(NSString *)emptyImage message:(NSString *)message buttonTitle:(NSString *)buttonTitle completion:(simpleCompletion)completion;

-(void)updateImage:(NSString *)emptyImage message:(NSString *)message buttonTitle:(NSString *)buttonTitle;

@end

NS_ASSUME_NONNULL_END
