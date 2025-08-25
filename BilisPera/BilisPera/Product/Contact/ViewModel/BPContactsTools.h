//
//  BPContactsTools.h
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPContactsTools : NSObject

+ (instancetype)shared;
- (void)fetchContactsAsJSON:(simpleStringCompletion)completion;

@end

NS_ASSUME_NONNULL_END
