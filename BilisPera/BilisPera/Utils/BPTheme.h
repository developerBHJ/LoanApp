//
//  BPTheme.h
//  BilisPera
//
//  Created by BHJ on 2025/8/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kFont(size) [UIFont systemFontOfSize:kRatio(size)]
#define kFontBold(size) [UIFont systemFontOfSize:kRatio(size) weight:UIFontWeightBold]
#define kFontMedium(size) [UIFont systemFontOfSize:kRatio(size) weight:UIFontWeightMedium]
#define kFontLight(size) [UIFont systemFontOfSize:kRatio(size) weight:UIFontWeightLight]

#define kBlackColor  [UIColor blackColor]
#define kWhiteColor  [UIColor whiteColor]
#define kColor_FFF6F9  [UIColor colorWithHex:0xFFF6F9]
#define kColor_848176  [UIColor colorWithHex:0x848176]
#define kColor_351E29  [UIColor colorWithHex:0x351E29]
#define kColor_898989  [UIColor colorWithHex:0x898989]
#define kColor_929292  [UIColor colorWithHex:0x929292]
#define kColor_727272  [UIColor colorWithHex:0x727272]
#define kColor_6C6C6C  [UIColor colorWithHex:0x6C6C6C]
#define kColor_FFDDE8  [UIColor colorWithHex:0xFFDDE8]
#define kColor_B43E64  [UIColor colorWithHex:0xB43E64]
#define kColor_FF9C00  [UIColor colorWithHex:0xFF9C00]
#define kColor_5B2941  [UIColor colorWithHex:0x5B2941]
#define kColor_979797  [UIColor colorWithHex:0x979797]
#define kColor_F7BCDE  [UIColor colorWithHex:0xF7BCDE]
#define kColor_4E4E4E  [UIColor colorWithHex:0x4E4E4E]


@interface BPTheme : NSObject

@end

NS_ASSUME_NONNULL_END
