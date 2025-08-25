//
//  BPADTools.h
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPADTools : NSObject

+ (instancetype)shared;

@property (nonatomic, assign) NSInteger trackCount;

- (void)registerIDFAAndTrack;
-(NSString *)getIDFV;
-(NSString *)getIDFA;


@end

NS_ASSUME_NONNULL_END
