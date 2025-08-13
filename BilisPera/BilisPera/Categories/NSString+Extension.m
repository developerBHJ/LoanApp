//
//  NSString+Extension.m
//  BilisPera
//
//  Created by BHJ on 2025/8/7.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+(NSString *)randomString{
    return [[[[NSUUID UUID] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
}

-(NSURL *)getHtmlUrl{
    NSString *path = self;
    if ([self containsString:@"?"]) {
        path = [NSString stringWithFormat:@"%@%@%@",
                self,
                @"&",
                [APIService pulicParmas].toURLStrings];
    }else{
        path = [NSString stringWithFormat:@"%@%@%@",
                self,
                @"?",
                [APIService pulicParmas].toURLStrings];
    }
    NSString *encodeStr = [path stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:encodeStr];
    if (url) {
        return url;
    }
    return nil;
}

- (NSAttributedString *)addUnderline {
    if (self.length == 0) {
        return nil;
    }
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attStr addAttributes:@{
        NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
        NSBaselineOffsetAttributeName: @(6)
    } range:NSMakeRange(0, self.length)];
    return attStr;
}

- (NSString *)safePhoneNumberWithLength:(NSInteger)lg {
    if (self.length < lg + 3) {
        return @"";
    }
    NSString *seSting = @"***********";
    NSString *replacement = [seSting substringFromIndex:seSting.length - lg];
    return [self stringByReplacingCharactersInRange:NSMakeRange(3, lg) withString:replacement];
}






@end
