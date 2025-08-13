//
//  ADTool.h
//  BilisPera
//
//  Created by BHJ on 2025/8/6.
//

#import <Foundation/Foundation.h>
#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
NS_ASSUME_NONNULL_BEGIN

@interface ADTool : NSObject

@property (nonatomic, copy, readonly) NSString *idfvString;
@property (nonatomic, copy) NSString *idfaString;
@property (nonatomic, assign) NSInteger trackCount;

+ (instancetype)shared;
- (void)registerIDFAAndTrack;
- (void)registerIDFAWithCompletion:(void(^)(BOOL success))completion;

@end

NS_ASSUME_NONNULL_END
