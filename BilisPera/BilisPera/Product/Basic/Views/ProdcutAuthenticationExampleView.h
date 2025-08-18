//
//  ProdcutAuthenticationExampleView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProdcutAuthenticationExampleViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<NSString *> *items;

- (instancetype)initWith:(NSString *)title items:(NSArray<NSString *> *)items;

@end

@interface ProdcutAuthenticationExampleView : UIView

- (instancetype)initWithFrame:(CGRect)frame model:(ProdcutAuthenticationExampleViewModel *)model;
@property (nonatomic, strong) ProdcutAuthenticationExampleViewModel *model;

@end

NS_ASSUME_NONNULL_END
