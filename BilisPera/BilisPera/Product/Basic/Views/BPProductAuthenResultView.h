//
//  BPProductAuthenResultView.h
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

#import <Foundation/Foundation.h>
#import "BPProductAuthenResultItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPProductAuthenResultViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *rightImageName;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSArray<BPProductAuthenResultItemViewModel *> *items;
@property (nonatomic, copy) simpleCompletion completion;

@end

@interface BPProductAuthenResultView : UIView

@property (nonatomic, strong) BPProductAuthenResultViewModel *model;

@end

NS_ASSUME_NONNULL_END
