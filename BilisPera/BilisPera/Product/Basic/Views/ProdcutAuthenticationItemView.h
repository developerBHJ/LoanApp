//
//  ProdcutAuthenticationItemView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutAuthenticationItemViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL needLine;
- (instancetype)initWith:(NSString *)title needLine:(BOOL)needLine completion:(simpleStringCompletion)completion;
@property (nonatomic, copy) simpleStringCompletion completion;


@end

@interface ProdcutAuthenticationItemView : UIView

@property (nonatomic, strong) ProdcutAuthenticationItemViewModel *model;
- (instancetype)initWithFrame:(CGRect)frame model:(ProdcutAuthenticationItemViewModel *)model;

@end

NS_ASSUME_NONNULL_END
