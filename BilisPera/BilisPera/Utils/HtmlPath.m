//
//  HtmlPath.m
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import "HtmlPath.h"

NS_ASSUME_NONNULL_BEGIN

@implementation HtmlPath

+(NSURL *)getUrl:(BPHtmlPath)type{
    NSString *path = @"";
    NSString *host = kH5Host;
    switch (type) {
        case BPHtmlPathPrivacy:
            path = @"/lampCupcake";
            host = kBaseUrl;
            break;
        case BPHtmlPathLoan:
            path = @"/zebraTeriya";
            break;
        case BPHtmlPathLoanDetail:
            path = @"/lemonShallo";
            break;
        case BPHtmlPathLoginFail:
            path = @"/dragonCream";
            break;
        case BPHtmlPathRepayment:
            path = @"/quxeenPapay";
            break;
        case BPHtmlPathRepaySuccess:
            path = @"/volcanoBirc";
            break;
        case BPHtmlPathRepayOfDelay:
            path = @"/sorbetScorp";
            break;
        case BPHtmlPathChangeCard:
            path = @"/mapleWillow";
            break;
        case BPHtmlPathCustomerService:
            path = @"/xylophonist";
            host = kBaseUrl;
            break;
        case BPHtmlPathRecommendList:
            path = @"/nutmegEggpl";
            break;
        case BPHtmlPathServiceHome:
            path = @"/eggArugulaW";
            break;
        case BPHtmlPathServiceComplain:
            path = @"/qinchuVanil";
            break;
        case BPHtmlPathServiceComplainDetail:
            path = @"/quillRhinoc";
            break;
        case BPHtmlPathContactUs:
            path = @"/hippoWaterm";
            break;
        case BPHtmlPathLoanAgreement:
            path = @"/yachtSheoak";
            break;
        case BPHtmlPathLoanFraud:
            path = @"/blueberryOn";
            break;
    }
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",host,path]];
}

@end

NS_ASSUME_NONNULL_END
