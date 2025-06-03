//
//  HttpRequest.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/14.
//

import Foundation
import Alamofire
import Moya

private let requestClosure = { (endpoint: Endpoint, closure: (Result<URLRequest, MoyaError>) -> Void)  -> Void in
    do {
        var  urlRequest = try endpoint.urlRequest()
        urlRequest.timeoutInterval = 30.0
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        urlRequest.httpShouldHandleCookies = false
        closure(.success(urlRequest))
        // 打印请求参数
        if let requestData = urlRequest.httpBody {
            HJPrint("请求参数：\n" + "\(urlRequest.url!)" + "\n" + "\(urlRequest.httpMethod ?? "")" + "发送参数" + "\(String(data: urlRequest.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        }
    } catch MoyaError.requestMapping(let url) {
        closure(.failure(MoyaError.requestMapping(url)))
    } catch MoyaError.parameterEncoding(let error) {
        closure(.failure(MoyaError.parameterEncoding(error)))
    } catch {
        closure(.failure(MoyaError.underlying(error, nil)))
    }
}

class HttpRequest{
    typealias successCompletion = ([String:Any]?) -> Void
    typealias failureCompletion = (SLError?) -> Void
    private static let statusCodeKey = "article"
    private static let statusMessageKey = "wondered"
    private static let dataKey = "howl"
    
    @MainActor
    static func request<T:TargetType>(target: T,
                                      showLoading: Bool = false,showMessage: Bool = false) async throws -> Result<Any?,SLError>{
        return await withCheckedContinuation { continuation in
            let requestProvider = MoyaProvider<T>(requestClosure: requestClosure)
            if showLoading{
                SLProgressHUD.showWindowesLoading(message: "")
            }
            requestProvider.request(target) { result in
                SLProgressHUD.hideHUDQueryHUD()
                switch result{
                case let .success(response):
                    do{
                        if let decordeResponse = try response.mapJSON() as? [String: Any]{
                            let data = decordeResponse[HttpRequest.dataKey]
                            let message = decordeResponse[HttpRequest.statusMessageKey] as? String ?? ""
                            let code = (decordeResponse[HttpRequest.statusCodeKey] as? String)?.toInt() ?? -1
                            if code == 0{
                                continuation.resume(returning: .success(data))
                            }else if code == -2{
                                continuation.resume(returning: .failure(SLError.tokenExpired(code: code)))
                            }else{
                                continuation.resume(returning: .failure(SLError.tokenExpired(code: nil)))
                            }
                            if !message.isEmpty,code != 0,showMessage{
                                SLProgressHUD.showWindowesLoading(message: message,autoHide: true)
                            }
                        }else{
                            continuation.resume(returning: .failure(SLError.tokenExpired(code: nil)))
                        }
                    } catch {
                        continuation.resume(returning: .failure(SLError.failed(error: error)))
                    }
                case let .failure(error):
                    continuation.resume(returning: .failure(SLError.failed(error: error)))
                }
            }
        }
    }
}

public func HttpRequestDictionary(_ target: TargetType,showLoading: Bool = false,showMessage: Bool = false,keyPath: String? = nil) async -> [String: Any]?{
    let result = try? await HttpRequest.request(target: target, showLoading: showLoading,showMessage: showMessage)
    switch result {
    case let .success(response):
        var resultDic: [String: Any] = [:]
        if let dataStr = response as? String,let dic = dataStr.toDictionary(){
            resultDic = dic
        }
        if let dic = response as? [String: Any]{
            resultDic = dic
        }
        return resultDic
    default:
        return nil
    }
}

public func HttpRequest<T: Serializable>(_ target: TargetType,showLoading: Bool = false,showMessage: Bool = false,keyPath: String? = nil) async -> T{
    let result = try? await HttpRequest.request(target: target, showLoading: showLoading,showMessage: showMessage)
    switch result {
    case let .success(response):
        var resultDic: [String: Any]?
        if let dataStr = response as? String,let dic = dataStr.toDictionary(){
            resultDic = dic
        }
        if let dic = response as? [String: Any]{
            resultDic = dic
        }
        guard let dic = resultDic else {return T()}
        if let keyPath = keyPath,let keyDic = dic[keyPath] as? [String: Any]{
            return T.model(from: keyDic)
        }
        return T.model(from: dic)
    default:
        return T()
    }
}

func randomUUIDString() -> String{
    return UUID().uuidString.replacingOccurrences(of: "-", with: "").lowercased()
}
