//
//  WebViewController.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/14.
//

import UIKit
import WebKit
import MessageUI
import StoreKit

class WebViewController: UIViewController,BaseViewController {
    var url : String?{
        didSet{
            loadRequest()
        }
    }
    
    var webView : WKWebView = {
        let config = WKWebViewConfiguration.init()
        config.applicationNameForUserAgent = "skyLoan"
        let userController = WKUserContentController()
        //        let js = " $('meta[name=description]').remove(); $('head').append( '' );"
        let scaleJS = "var script = document_createElement_x_x('meta');"
        let script = WKUserScript.init(source: scaleJS, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        // 禁止长按
        var javascript = "document.documentElement.style.webkitTouchCallout='none';"
        // 禁止选中
        javascript.append("document.documentElement.style.webkitUserSelect='none';")
        let noneSelectScript = WKUserScript.init(source: javascript, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        userController.addUserScript(script)
        userController.addUserScript(noneSelectScript)
        config.userContentController = userController
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        config.preferences = preferences
        config.userContentController = WKUserContentController()
        let webView = WKWebView.init(frame: .zero, configuration: config)
        webView.backgroundColor = .clear
        //        webView.hack_removeInputAccessory()
        // 禁止回弹
        webView.scrollView.bounces = false
        return webView
    }()
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView.init(frame: .zero)
        view.tintColor = AppTheme.themeColor      // 进度条颜色
        view.trackTintColor = UIColor.white // 进度条背景色
        return view
    }()
    
    lazy var navBar: CustomNavigationBar = {
        let view = CustomNavigationBar(frame: .init(x: 0, y: 0, width: kScreenW, height: kNavigationBarH))
        view.backgroundColor = .white
        return view
    }()
    
    var bridge: JSBridge?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bridge = JSBridge.init(webView: webView)
        registerJSMethod()
        webView.navigationDelegate = self
        webView.uiDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.removeCache()
        hiddenNavigationBar = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    var hiddenNavigationBar: Bool{
        true
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.uiDelegate = nil
        webView.navigationDelegate = nil
    }
}

extension WebViewController{
    func setupUI(){
        view.backgroundColor = .white
        view.addSubview(navBar)
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(3.ratio())
        }
    }
    
    func loadRequest(){
        let request = URLRequest.init(url: URL.init(string: url!)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        self.webView.load(request)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
    
    // 清楚H5缓存
    func removeCache() {
        let websiteDataTypes = NSSet.init(set: [WKWebsiteDataTypeDiskCache,WKWebsiteDataTypeMemoryCache,WKWebsiteDataTypeCookies])
        let dateFrom = NSDate.init(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: dateFrom as Date) {
        }
        URLCache.shared.removeAllCachedResponses()
    }
    
    override func popNavigation(animated: Bool = true) {
        if webView.canGoBack {
            webView.goBack()
        }else{
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func registerJSMethod() {
        bridge?.registerHandler(JSMethod.uploadRiskLoan.rawValue) { params in
            if let list = params as? [String]{
                let productId = list.first ?? ""
                TrackMananger.shared.trackRisk(type: .finish, productId: productId)
            }
        }
        
        bridge?.registerHandler(JSMethod.jumpToHome.rawValue) { params in
            RouteManager.shared.routeTo("blue://sky.yes.app/octopusTarra")
        }
        
        bridge?.registerHandler(JSMethod.openUrl.rawValue) { params in
            guard let url  = params as? String else {return}
            RouteManager.shared.routeTo(url)
        }
        
        bridge?.registerHandler(JSMethod.closeSyn.rawValue) {[weak self] params in
            self?.popNavigation()
        }
        
        bridge?.registerHandler(JSMethod.toGrade.rawValue) {[weak self] params in
            self?.openAppStoreRatingPage()
        }
        
        bridge?.registerHandler(JSMethod.callPhoneMethod.rawValue) {[weak self] params in
            guard let email = params as? String else {return}
            self?.sendEmail(email: email)
        }
    }
}

extension WebViewController:WKUIDelegate,WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        navBar.title = webView.title ?? ""
    }
    
    // 接收到服务器跳转请求之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        HJPrint("navigationResponse" + navigationResponse.response.url!.absoluteString)
        if navigationResponse.response.url?.absoluteString == "" {
            decisionHandler(.cancel)
        }else{
            //允许跳转
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if navigationAction.targetFrame?.isMainFrame != true {
            webView.load(navigationAction.request)
        }
        return nil
    }
}


extension WebViewController{
    func openAppStoreRatingPage() {
        guard let windowScene = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .first as? UIWindowScene else {return}
        SKStoreReviewController.requestReview(in: windowScene)
    }
    
    func sendEmail(email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self // 设置代理
            mail.setToRecipients([email]) // 收件人地址
            let subject = "APP:\(appName)\nPhone:\(LoginTool.shared.getUserName())"
            mail.setSubject(subject)
            present(mail, animated: true)
        }else{
            showCustomAlert(title: "Friendly Tips", message: "Unable to send email, please check the email account settings on your device.")
        }
    }
}

extension WebViewController: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: (any Error)?) {
        controller.dismiss(animated: true)
    }
}
