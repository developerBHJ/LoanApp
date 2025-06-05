//
//  PersonalInfoViewController+Event.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/27.
//

import Foundation
import UIKit

protocol PersonalInfoViewEventDelegate {
    func showAlertView(isAddress: Bool,title: String,key: String,options: [ProductFormItem])
    func saveUserInfo(key: String,value: String)
}

extension PersonalInfoViewController: PersonalInfoViewEventDelegate{
    override func nextEvent() {
        Task{
            guard await viewModel.saveBasicInfo() else {return}
            TrackMananger.shared.endTime = CFAbsoluteTimeGetCurrent()
            TrackMananger.shared.trackRisk(type: .personal, productId: viewModel.productId)
            ProductEntrance.shared.onPushAuthenView()
        }
    }
    
    func showAlertView(isAddress: Bool,title: String,key: String, options: [ProductFormItem]) {
        if isAddress{
            showAddressPickerView(key: key)
        }else{
            showCommonAlertView(title: title, key: key, options: options)
        }
    }
    
    func showCommonAlertView(title: String,key: String, options: [ProductFormItem]){
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
    
    @MainActor
    func showAddressPickerView(key: String) {
        if LoginTool.shared.addressList.isEmpty {
            Task{
                await LoginTool.shared.requestAddressList()
            }
        }
        var selectedAddress: String?
        var isFullAddress: Bool = false
        let selectedView = AddressPickerView.init(frame: .zero, model: .init(valueChanged: { address,result in
            selectedAddress = address
            isFullAddress = result
            HJPrint(selectedAddress)
        }))
        let alertVC = ProductAlertViewController(model: .init(titleImage:"icon_select Address",contentView: selectedView,buttonImage: "icon_product_alert_button_yes",isAddressView: true,confirmCompletion: {
            [weak self] in
            if isFullAddress{
                self?.saveUserInfo(key: key, value: selectedAddress ?? "")
            }else{
                SLProgressHUD.showToast(message: LocalizationConstants.Alert.selectedCityToast)
            }
        }))
        present(alertVC, animated: true)
    }
    
    func saveUserInfo(key: String, value: String) {
        let item = ProductEditItem.init(key: key,value: value)
        self.saveUserInfo(item: item)
    }
    
    func saveUserInfo(item: ProductEditItem){
        self.viewModel.saveUserInfo(item: item)
        self.viewModel.updateEditData()
        self.listView.reloadData()
        self.updateHeaderView()
    }
}
