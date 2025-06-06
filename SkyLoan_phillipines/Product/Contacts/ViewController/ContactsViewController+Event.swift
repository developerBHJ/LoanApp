//
//  ContactsViewController+Event.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/28.
//

import Foundation
import ContactsUI

protocol ContactsViewEventDelegate {
    func showAlertView(title: String,key: String,options: [ProductFormItem])
    func onPushContactsView()
}

extension ContactsViewController: ContactsViewEventDelegate{
    override func nextEvent() {
        Task{
            guard await viewModel.saveBasicInfo() else {return}
            TrackMananger.shared.endTime = CFAbsoluteTimeGetCurrent()
            trackContactsInfo()
            TrackMananger.shared.trackRisk(type: .contacts, productId: viewModel.productId)
            ProductEntrance.shared.onPushAuthenView()
        }
    }
    
    func showAlertView(title: String,key: String, options: [ProductFormItem]) {
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
            self?.saveUserInfo(key: key, relation: selectedType ?? "", relationKey: optinKey ?? "")
        }))
        present(alertVC, animated: true)
    }
    
    func onPushContactsView() {
        Task{
            if await PermissionHandle.shared.requestContactsAccess() {
                let picker = CNContactPickerViewController()
                picker.delegate = self
                picker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
                present(picker, animated: true)
            }else{
                showCustomAlert(title: "", message: "To use Sky Loan,you must enable contacts permissions to use the Appfunctions normally", confirmCompletion:  {
                    RouteManager.shared.routeTo("blue://sky.yes.app/lasagnaGiraf")
                })
            }
        }
    }
    
    func saveUserInfo(key: String,relation: String,relationKey: String){
        self.viewModel.saveUserInfo(key: key,relationKey: relationKey,relationName: relation)
        self.viewModel.updateEditData()
        self.listView.reloadData()
        self.updateHeaderView()
    }
    
    func trackContactsInfo(){
        Task{
            guard let jsons = await ContactJSONManager.shared.fetchContactsAsJSON() else {return}
            let dic = ["general":"3","howl": jsons]
            TrackMananger.shared.tackContactsInfo(paramas: dic)
        }
    }
}


extension ContactsViewController: CNContactPickerDelegate{
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
        var phone = ""
        if let firstPhone = contact.phoneNumbers.first {
            phone = firstPhone.value.stringValue
        }
        if fullName.isEmpty || phone.isEmpty {
            let message = "The name and phone number of the contact person cannot be empty"
            SLProgressHUD.showToast(message: message)
            return
        }
        viewModel.saveUserInfo(key: viewModel.currentKey,name: fullName,phone: phone)
        self.viewModel.updateEditData()
        self.listView.reloadData()
        self.updateHeaderView()
    }
}

