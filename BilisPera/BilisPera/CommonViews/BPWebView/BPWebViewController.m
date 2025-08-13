//
//  BPWebViewController.m
//  BilisPera
//
//  Created by BHJ on 2025/8/11.
//

#import "BPWebViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPWebViewController ()<WKNavigationDelegate,WKUIDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) BPJSBridgeHandle *jsBridge;

@end


@implementation BPWebViewController

- (void)setUrl:(NSString *)url {
    _url = [url copy];
    [self loadRequest];
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.applicationNameForUserAgent = @"bilisPera";
        WKUserContentController *userController = [[WKUserContentController alloc] init];
        NSString *scaleJS = @"var script = document_createElement_x_x('meta');";
        WKUserScript *script = [[WKUserScript alloc] initWithSource:scaleJS
                                                      injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
                                                   forMainFrameOnly:NO];
        
        NSMutableString *javascript = [NSMutableString string];
        [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];
        [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];
        WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript
                                                                injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
                                                             forMainFrameOnly:NO];
        
        [userController addUserScript:script];
        [userController addUserScript:noneSelectScript];
        config.userContentController = userController;
        
        WKWebpagePreferences *preferences = [[WKWebpagePreferences alloc] init];
        preferences.allowsContentJavaScript = YES;
        config.defaultWebpagePreferences = preferences;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        _webView.backgroundColor = [UIColor clearColor];
        _webView.scrollView.bounces = NO;
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
        _progressView.tintColor = kBlackColor; // 进度条颜色
        _progressView.trackTintColor = [UIColor whiteColor]; // 进度条背景色
    }
    return _progressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    self.jsBridge = [[BPJSBridgeHandle alloc] initWithWebView:self.webView];
    [self registerJSMethod];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    self.webView.UIDelegate = nil;
    self.webView.navigationDelegate = nil;
}

-(void)configUI{
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavigationBarHeight);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavigationBarHeight);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(3);
    }];
}

-(void)registerJSMethod{
    kWeakSelf;
    [self.jsBridge registerHandler:BPJSMethod.uploadRiskLoan handler:^(id params) {
        if ([params isKindOfClass: [NSArray class]]) {
            NSArray *parmas = (NSArray *)params;
            NSString *productId = [NSString stringWithFormat:@"%@",
                                   parmas.firstObject];
            
        }
    }];
    
    [self.jsBridge registerHandler:BPJSMethod.openUrl handler:^(id params) {
        if ([params isKindOfClass: [NSString class]]) {
            NSString *url = [NSString stringWithFormat:@"%@",params];
        }
    }];
    
    [self.jsBridge registerHandler:BPJSMethod.closeSyn handler:^(id url) {
        [self popNavigation:YES];
    }];
    
    [self.jsBridge registerHandler:BPJSMethod.jumpToHome handler:^(id params) {
        
    }];
    
    [self.jsBridge registerHandler:BPJSMethod.callPhoneMethod handler:^(id params) {
        if ([params isKindOfClass: [NSString class]]) {
            NSString *email = [NSString stringWithFormat:@"%@",params];
            [weakSelf sendEmail:email];
        }
    }];
    
    [self.jsBridge registerHandler:BPJSMethod.toGrade handler:^(id params) {
        [weakSelf openAppStoreRatingPage];
    }];
}

-(void)loadRequest{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
    [self.webView loadRequest:request];
}

// MARK: - Observe
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:( nullable NSDictionary<NSKeyValueChangeKey,id> *)change context:(nullable void *)context{
    if ([keyPath  isEqual: @"estimatedProgress"]) {
        self.progressView.alpha = 1.0;
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
        if (self.webView.estimatedProgress >= 1.0) {
            [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.alpha = 0;
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0 animated:NO];
            }];
        }
    }
}

// MARK: - Method
-(void)openAppStoreRatingPage{
    UIWindowScene *windowScene = nil;
    for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
        if (scene.activationState == UISceneActivationStateForegroundActive) {
            windowScene = (UIWindowScene *)scene;
            break;
        }
    }
    if (!windowScene) {
        return;
    }
    [SKStoreReviewController requestReviewInScene:windowScene];
}

- (void)sendEmail:(NSString *)email {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self; // 设置代理
        NSString *emailPath = [[email componentsSeparatedByString:@":"] lastObject] ?: @"";
        [mail setToRecipients:@[emailPath]]; // 收件人地址
        NSString *subject = [NSString stringWithFormat:@"APP:%@\nPhone:%@",
                             kAppName,
                             [LoginTools.shared getUserName]];
        [mail setMessageBody:subject isHTML:NO];
        [self presentViewController:mail animated:YES completion:nil];
    }
}

// MARK: - WKWebViewDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    self.navigationItem.title = webView.title ?: @"";
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(WK_SWIFT_UI_ACTOR void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"%@",
          [NSString stringWithFormat:@"%@",
           navigationResponse.response.URL.absoluteString]);
    if ([navigationResponse.response.URL.absoluteString isEqualToString:@""]) {
        decisionHandler(WKNavigationResponsePolicyCancel);
    }else{
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
}

- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}


// MARK: - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end

NS_ASSUME_NONNULL_END
