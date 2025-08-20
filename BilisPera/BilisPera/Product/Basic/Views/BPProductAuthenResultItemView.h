//
//  BPProductAuthenResultItemView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPProductAuthenResultItemViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
- (instancetype)init:(NSString *)title content:(NSString *)content;

@end

@interface BPProductAuthenResultItemView : UIView

@property (nonatomic, strong) BPProductAuthenResultItemViewModel *model;

@end

NS_ASSUME_NONNULL_END
