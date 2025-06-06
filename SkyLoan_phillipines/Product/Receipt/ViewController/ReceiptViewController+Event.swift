//
//  ReceiptViewController+Event.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/29.
//

import Foundation
import UIKit

protocol ReceiptViewEventDelegate {
    func showAlertView(isAddress: Bool,title: String,key: String,options: [ProductFormItem])
    func refreshData()
}

extension ReceiptViewController: ReceiptViewEventDelegate{
    override func nextEvent() {
        Task{
            guard await viewModel.saveBasicInfo() else {return}
            TrackMananger.shared.endTime(type: .receipt)
            TrackMananger.shared.trackRisk(type: .receipt, productId: viewModel.productId)
            ProductEntrance.shared.onPushAuthenView()
        }
    }
    
    func showAlertView(isAddress: Bool,title: String,key: String, options: [ProductFormItem]) {
        var selectedType: String?
        let cellDatas = options.map { item in
            IDCardAuthenTypeCell.Model(title: item.nowadays)
        }
        let selectedView = IDCardAuthenTypeSelectedView.init(frame: .zero, model: .init(cellType: IDCardAuthenTypeCell.self,contentViewHeight: 180.ratio(),dataSource: [.init(cellType: IDCardAuthenTypeCell.self,cellDatas: cellDatas)],selectedCompletion: { type in
            selectedType = type
        }))
        let alertVC = ProductAlertViewController(model: .init(title: title,contentView: selectedView,buttonImage: "icon_product_alert_button_yes",confirmCompletion: {
            [weak self] in
            let optinKey = options.first(where: {$0.nowadays == selectedType})?.general
            let item = ProductEditItem.init(key: key,value: selectedType ?? "",general: optinKey ?? "")
            self?.saveUserInfo(item: item)
        }))
        present(alertVC, animated: true)
    }
    
    func saveUserInfo(item: ProductEditItem){
        self.viewModel.saveUserInfo(item: item)
        refreshData()
    }
    
    func refreshData() {
        self.viewModel.updateEditData()
        self.listView.reloadData()
        self.updateHeaderView()
    }
}


