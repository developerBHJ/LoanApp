//
//  RouteManager.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/29.
//

import Foundation
import UIKit

enum Route: String {
    case setting = "/lasagnaGiraf"
    case homePage = "/octopusTarra"
    case login = "/radishGreenb"
    case productDetail = "/duckSnappeaV"
}

class RouteManager {
    static let shared = RouteManager()
    private var routes = [String: RouteHandler]()
    
    typealias RouteHandler = (URL, [String: String]) -> Void
    
    private init() {}
    
    // 注册路由模式
    func register(pattern: String, handler: @escaping RouteHandler) {
        routes[pattern] = handler
    }
    
    // 注册路由模式
    func register(pattern: String,host: String? = nil, handler: @escaping RouteHandler) {
        routes[pattern] = handler
    }
    
    // 处理URL路由
    func handle(url: URL) -> Bool {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return false
        }
        // 提取URL参数
        var params = [String: String]()
        components.queryItems?.forEach { item in
            params[item.name] = item.value
        }
        // 匹配注册的路由
        for (pattern, handler) in routes {
            if isMatch(url: url, pattern: pattern) {
                handler(url, params)
                return true
            }
        }
        return false
    }
    
    private func isMatch(url: URL, pattern: String) -> Bool {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let patternComponents = URLComponents(string: pattern) else {
            return false
        }
        // 比较scheme和host
        return urlComponents.scheme == patternComponents.scheme &&
        urlComponents.host == patternComponents.host
    }
}

extension RouteManager{
    
    func routeTo(_ url: String){
        guard !url.isEmpty else {return}
        if url.hasPrefix("http") || url.hasPrefix("https"){
            guard let urlStr = url.getHtmlUrl() else {return}
            _ = handle(url: urlStr)
        }else{
            guard let urlStr = URL(string: url) else {return}
            _ = handle(url: urlStr)
        }
    }
    
    @MainActor
    func regisetrRoutes(){
        
        RouteManager.shared.register(pattern: "blue://sky.yes.app") {[weak self] url, paramas in
            self?.handleRouter(route: Route.init(rawValue: url.path) ?? .homePage, pramas: paramas)
        }
        
        RouteManager.shared.register(pattern: kH5Host) {[weak self] url, paramas in
            self?.onPushWebView(url: url.absoluteString)
        }
        
        RouteManager.shared.register(pattern: kH5Host1) {[weak self] url, paramas in
            self?.onPushWebView(url: url.absoluteString)
        }
    }
    
    @MainActor
    func handleRouter(route: Route,pramas: [String:Any] = [:]){
        switch route {
        case .homePage:
            if let homeVC = UIViewController.topMost?.navigationController?.children.first(where: {$0 is HomePageViewController}){
                UIViewController.topMost?.navigationController?.popToViewController(homeVC, animated: true)
            }
        case .login:
            LoginTool.shared.showLoginView()
        case .setting:
            if let url = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(url)
            }
        case .productDetail:
            guard let disappointed = pramas["disappointed"] else {return}
            ProductEntrance.shared.onPushAuthenView(productId: "\(disappointed)")
        }
    }
    
    func onPushWebView(url: String){
        let webView = WebViewController()
        webView.url = url
        UIViewController.topMost?.navigationController?.pushViewController(webView, animated: true)
    }
}
