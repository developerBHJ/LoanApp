//
//  JSBridge.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/14.
//

import Foundation
import UIKit
import WebKit

enum JSMethod: String{
    /// 风控埋点
    case uploadRiskLoan = "pumpkinGr"
    /// 跳转原生或者H5
    case openUrl = "lemonFigA"
    /// 关闭当前 H5
    case closeSyn = "herbsTouc"
    /// 回到 App 首页
    case jumpToHome = "xiaoxueMa"
    /// 发邮件
    case callPhoneMethod = "nutQuince"
    /// 弹出 App 系统评分弹窗
    case toGrade = "herringKi"
}

class JSBridge:NSObject {
    private weak var webView: WKWebView?
    private var messageHandlers = [String: (Any) -> Void]()
    
    init(webView: WKWebView) {
        self.webView = webView
        super.init()
        setupConfiguration()
    }
    
    deinit {
        webView?.configuration.userContentController.removeScriptMessageHandler(forName: "nativeBridge")
    }
    
    private func setupConfiguration(){
        webView?.configuration.userContentController.add(self, name: "nativeBridge")
    }
    
    func registerHandler(_ name: String, handler: @escaping (Any) -> Void) {
        messageHandlers[name] = handler
    }
    
    func callJS(_ method: String, params: [String: Any] = [:], completion: ((Any?, Error?) -> Void)? = nil) {
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        let jsonString = jsonData.flatMap { String(data: $0, encoding: .utf8) } ?? "{}"
        let js = "window.\(method)(\(jsonString))"
        Task{
            await MainActor.run {
                self.webView?.evaluateJavaScript(js) { result, error in
                    completion?(result, error)
                }
            }
        }
    }
}

extension JSBridge: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard message.name == "nativeBridge",
              let body = message.body as? [String: Any],
              let method = body["method"] as? String,
              let handler = messageHandlers[method] else { return }
        handler(body["params"] ?? NSNull())
    }
}
