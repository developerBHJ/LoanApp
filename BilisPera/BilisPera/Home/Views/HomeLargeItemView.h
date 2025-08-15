//
//  HomeLargeItemView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeLargeItemViewModel : NSObject

- (instancetype)initWith:(NSString *)title imageName:(NSString *)imageName completion:(nullable simpleCompletion)completion;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *ImageName;
@property (nonatomic, copy,nullable) simpleCompletion completion;

@end

@interface HomeLargeItemView : UIView

@property (nonatomic, strong) HomeLargeItemViewModel *model;
- (instancetype)initWithFrame:(CGRect)frame model:(HomeLargeItemViewModel *)model;

@end

NS_ASSUME_NONNULL_END
