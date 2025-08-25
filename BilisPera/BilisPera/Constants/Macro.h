//
//  Macro.h
//  BilisPera
//
//  Created by BHJ on 2025/8/6.
//

#ifndef Macro_h
#define Macro_h
// 屏幕宽
#define kScreenW [UIScreen mainScreen].bounds.size.width
// 屏幕高
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define Is_Iphone ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)

#define Is_IPhoneX (kScreenW >=375.0f && kScreenH >=812.0f && Is_Iphone)
//
#define kRatio(x) (kScreenW / 375.0) * x
// 状态栏高度
#define kStatusBarHeight (Is_IPhoneX ? (44.0):(20.0))
// 底部安全区域高度
#define kSafeAreaBottomHeight (Is_IPhoneX ? (34.0):(0))
// TabBar高度
#define kTabBarHeight (Is_IPhoneX ? (49.0 + 34.0):(49.0))
// 导航栏高度
#define kNavigationBarHeight (44 + kStatusBarHeight)

#define kCustomTabBarH (kRatio(75) + kRatio(10) + kSafeAreaBottomHeight)

#define kWeakSelf __weak typeof(self) weakSelf = self;
#define kUserDefaultSet(obj,key) [[NSUserDefaults standardUserDefaults]setObject:obj forKey:key]
#define kUserDefaultRmove(key) [[NSUserDefaults standardUserDefaults]removeObjectForKey:key]

// 根据名称获取图片
#define kGetImage(name) [UIImage imageNamed:name]

#define kAlertShowTime 3.0


#define kAppVersion [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]
#define kAppName [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"]
#define kDeviceSystemVersion [[UIDevice currentDevice] systemVersion]
#define kDeviceName [[UIDevice currentDevice] name]
#define kDeviceModel [[UIDevice currentDevice] model]
#define kDeviceUUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

// baseUrl
#define kBaseUrl @"http://8.212.166.255:9993"
// H5 Host
#define kH5Host @"http://8.212.166.255:9893"
#define kH5Host1 @"https://8.212.166.255:9893"

#define kScheme @"app://bilispera.ios.app"


#define kH5Path(path) [NSString stringWithFormat:@"%@%@",kH5Host,path]

typedef void(^simpleCompletion)(void);
typedef void(^simpleBoolCompletion)(BOOL);
typedef void(^simpleStringCompletion)(NSString *);
typedef void(^simpleIntCompletion)(NSInteger);
typedef void(^simpleObjectCompletion)(id);

static NSString *tokenKey = @"token";
static NSString *userNameKey = @"userName";
static NSString *loginStatusKey = @"loginStatus";
static NSString *bPageKey = @"bPageKey";
static NSString *isFirstLuanch = @"isFirst";
static NSString *userLocationKey = @"user_Location";


typedef NS_ENUM(NSInteger,BPOrderStatus) {
    BPOrderStatusAll = 4,
    BPOrderStatusApplying = 7,
    BPOrderStatusRepayment = 6,
    BPOrderStatusFinish = 5,
};

#endif /* Macro_h */
