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

@property (nonatomic, strong) NSString *idfvString;
@property (nonatomic, strong) NSString *idfaString;
@property (nonatomic, assign) NSInteger trackCount;

+ (instancetype)shared;
- (void)registerIDFAAndTrack;
- (void)registerIDFAWithCompletion:(void(^)(BOOL success))completion;

@end

NS_ASSUME_NONNULL_END
