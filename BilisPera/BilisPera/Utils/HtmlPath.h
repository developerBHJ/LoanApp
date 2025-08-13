//
//  HtmlPath.h
//  BilisPera
//
//  Created by BHJ on 2025/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,BPHtmlPath) {
    // 隐私协议
    BPHtmlPathPrivacy = 0,
    // 确认用款页
    BPHtmlPathLoan,
    // 订单详情
    BPHtmlPathLoanDetail,
    // 联登录失败
    BPHtmlPathLoginFail,
    // 还款
    BPHtmlPathRepayment,
    // 第三方还款成功中间页
    BPHtmlPathRepaySuccess,
    // 展期页面
    BPHtmlPathRepayOfDelay,
    // 换绑卡
    BPHtmlPathChangeCard,
    // 客服中心
    BPHtmlPathCustomerService,
    // 复贷推荐弹框
    BPHtmlPathRecommendList,
    // 智能客服首页
    BPHtmlPathServiceHome,
    // 智能客服投诉列表
    BPHtmlPathServiceComplain,
    // 智能客服投诉详情
    BPHtmlPathServiceComplainDetail,
    // 联系我们
    BPHtmlPathContactUs,
    // 借款协议
    BPHtmlPathLoanAgreement,
    // 诈骗页
    BPHtmlPathLoanFraud,
};

@interface HtmlPath : NSObject

+(NSURL *)getUrl:(BPHtmlPath)type;

@end

NS_ASSUME_NONNULL_END
