//
//  ProductEntrance.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/28.
//

import Foundation
import UIKit

class ProductEntrance{
    static let shared = ProductEntrance()
    private var productId: String = ""
    private var nextTitle: String = ""
    private var orderId: String = ""
    
    @MainActor
    func apply(productId: String = ""){
        if !productId.isEmpty{
            self.productId = productId
        }
        Task{
            if let url = await apply(),!url.isEmpty {
                RouteManager.shared.routeTo(url)
            }
        }
    }
    
    func onPushAuthenView(productId: String = ""){
        if !productId.isEmpty{
            self.productId = productId
        }
        Task{
            guard let model = await getNextStep(productId: self.productId) else {return}
            if let url = getUrl(model: model),!url.isEmpty{
                await onPushWebView(url: url)
            }else if let m = model.brain{
                nextTitle = m.feel
                await onPushAuthenView(type: m.fast ?? .iDCard)
            }else if let url = await getNextStepWitdh(orderId: orderId){
                await onPushWebView(url: url)
            }
        }
    }
    
    private func apply() async -> String?{
        guard !productId.isEmpty else {return nil}
        let result: [String: Any]? = await HttpRequestDictionary(ProductAPI.apply(disappointed: productId),showLoading: true,showMessage: true)
        if let url = result?["somehow"] as? String{
            return url
        }
        return nil
    }
    
    private func getNextStep(productId: String) async -> ProductDetailModel?{
        guard !productId.isEmpty else {return nil}
        let detailModel: ProductDetailModel = await HttpRequest(ProductAPI.getProductDetail(disappointed: productId),showLoading: true)
        if let ass = detailModel.confusion?.ass{
            self.orderId = ass
        }
        if let feel = detailModel.brain?.feel{
            self.nextTitle = feel
        }
        return detailModel
    }
    
    private func getUrl(model: ProductDetailModel) -> String?{
        guard model.disdainful != 200,!model.somehow.isEmpty else {return nil}
        let url = model.somehow + "?" + PublicParamas().toURLStrings()
        return url
    }
    
    private func getNextStepWitdh(orderId: String) async -> String?{
        TrackMananger.shared.startTime = CFAbsoluteTimeGetCurrent()
        guard !orderId.isEmpty else {return nil}
        let result: [String: Any]? = await HttpRequestDictionary(OrderAPI.getOrderDetail(counting: orderId),showLoading: true)
        if let url = result?["somehow"] as? String{
            TrackMananger.shared.endTime = CFAbsoluteTimeGetCurrent()
            TrackMananger.shared.trackRisk(type: .apply, productId: productId)
            return url
        }
        return nil
    }
    
    @MainActor
    private func onPushWebView(url: String){
        RouteManager.shared.routeTo(url)
    }
    
    @MainActor func onPushAuthenView(type:ProductItemType){
        switch type {
        case .iDCard:
            IDCardViewEntrance.shared.onPushIDCardView(title: nextTitle, productId:productId)
        case .basic:
            let basicVC = PersonalInfoViewController(title: nextTitle, productId: productId)
            UIViewController.topMost?.navigationController?.pushViewController(basicVC, animated: true)
        case .work:
            let workVC = WorkViewController(title: nextTitle, productId: productId)
            UIViewController.topMost?.navigationController?.pushViewController(workVC, animated: true)
        case .contact:
            let contactsVC = ContactsViewController(title: nextTitle, productId: productId)
            UIViewController.topMost?.navigationController?.pushViewController(contactsVC, animated: true)
        case .bank:
            let receiptVC = ReceiptViewController(title: nextTitle, productId: productId)
            UIViewController.topMost?.navigationController?.pushViewController(receiptVC, animated: true)
        }
    }
}
