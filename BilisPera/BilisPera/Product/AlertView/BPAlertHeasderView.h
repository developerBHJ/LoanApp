//
//  BPAlertHeasderView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPAlertHeasderViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL needClose;
@property (nonatomic, copy) simpleCompletion completion;
- (instancetype)initWith:(NSString *)title needClose:(BOOL)needClose completion:(simpleCompletion)completion;

@end

@interface BPAlertHeasderView : UIView

@property (nonatomic, strong) BPAlertHeasderViewModel *model;

@end

NS_ASSUME_NONNULL_END
