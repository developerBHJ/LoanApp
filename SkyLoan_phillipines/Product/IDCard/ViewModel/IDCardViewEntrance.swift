//
//  IDCardViewEntrance.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/25.
//

import Foundation
import UIKit
class IDCardViewEntrance {
    static let shared = IDCardViewEntrance()
    var infoModel: ProductInfoModel = .init()
    var cardType: VertifyType = .none
    var navTitle: String = ""
    var productId: String = ""
    
    private func requestInfoModel(productId: String) async -> ProductInfoModel?{
        guard !productId.isEmpty else {return nil}
        let model: ProductInfoModel = await HttpRequest(ProductAPI.getAuthenInfo(disappointed: productId))
        infoModel = model
        return model
    }
    
    private func getViewType(productId: String) async -> IDcardType{
        guard let detailModel = await requestInfoModel(productId: productId) else {return .selectCarType}
        guard let strenuous = detailModel.strenuous else {return .selectCarType}
        if strenuous.late == 0{// 选择认证证件类型
            return .selectCarType
        }else if strenuous.late == 1,detailModel.false == 0{
            return .face
        }else if  strenuous.late == 1,detailModel.false == 1{
            return .result
        }
        return .idCard
    }
    
    @MainActor
    func onPushIDCardView(title: String,productId: String){
        self.navTitle = title
        self.productId = productId
        Task{
            let type =  await getViewType(productId: productId)
            guard let topVC = UIViewController.topMost else {return}
            if type == .selectCarType,let selectedType = await showAlertAndGetSelectedType(topVC: topVC){
                let detailVC = IDCardViewController(viewType: .idCard,title: title,productId: productId,detailModel: infoModel,cardType: selectedType)
                topVC.navigationController?.pushViewController(detailVC, animated: true)
            }else{
                let detailVC = IDCardViewController(viewType: type,title: title,productId: productId,detailModel: infoModel)
                topVC.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
    
    @MainActor
    private func showAlertAndGetSelectedType(topVC: UIViewController) async -> VertifyType?{
        return await withCheckedContinuation {[weak self] continuation in
            self?.showSelectTypeView(topVC: topVC) { type in
                continuation.resume(returning: type)
            }
        }
    }
    
    @MainActor
    private func showSelectTypeView(topVC: UIViewController,completion: ((VertifyType?)-> Void)? = nil){
        guard !infoModel.detectives.isEmpty else {
            completion?(nil)
            return
        }
        TrackMananger.shared.startTime = CFAbsoluteTimeGetCurrent()
        var types: [String] = []
        infoModel.detectives.forEach { list in
            list.forEach { type in
                types.append(type.rawValue)
            }
        }
        let cellDatas = types.map { type in
            IDCardAuthenTypeCell.Model(title: type,isSelected: false)
        }
        var selectedType: String?
        let selectedView = IDCardAuthenTypeSelectedView.init(frame: .zero, model: .init(cellType: IDCardAuthenTypeCell.self,contentViewHeight: 180.ratio(),dataSource: [.init(cellType: IDCardAuthenTypeCell.self,cellDatas: cellDatas)],selectedCompletion: { type in
            selectedType = type
        }))
        let alertVC = ProductAlertViewController(model: .init(titleImage: "icon_product_authenType_title",contentView: selectedView,buttonImage: "icon_product_alert_button_yes",confirmCompletion: {[weak self] in
            completion?(VertifyType.init(rawValue: selectedType ?? ""))
            TrackMananger.shared.endTime = CFAbsoluteTimeGetCurrent()
            TrackMananger.shared.trackRisk(type: .authenSelect, productId: self?.productId ?? "")
        }))
        topVC.present(alertVC, animated: true)
    }
}
