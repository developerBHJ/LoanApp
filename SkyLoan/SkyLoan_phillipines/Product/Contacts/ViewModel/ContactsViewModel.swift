//
//  ContactsViewModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/28.
//

import Foundation
class ContactsViewModel {
    var productId: String = ""
    var dataSource: [UITableSectionModel] = []
    var itemList: [ContactsModel] = []
    var editData: [ContactsEditModel] = []
    var eventDelegate: ContactsViewEventDelegate?
    var currentKey: String = ""
    var isTracked: Bool = false
    
    func reloadData() async{
        guard !productId.isEmpty else {return}
        let result: [String: Any]? = await HttpRequestDictionary(ProductAPI.getContactsInfo(disappointed: productId))
        guard let even = result?["even"] as? [String: Any],let list = even["trust"] as? [[String: Any]] else {return}
        let modelList = ContactsModel.modelArray(from: list)
        self.itemList = modelList
        configSections(list: modelList)
    }
    
    func configSections(list: [ContactsModel]){
        guard !list.isEmpty else {return}
        list.forEach { model in
            if !model.nowadays.isEmpty{
                let relation = model.collaborated.first(where: {$0.general == model.foreigners})?.nowadays ?? ""
                saveUserInfo(key: model.satisfied,name: model.nowadays,phone: model.belgian,relationKey: model.foreigners,relationName: relation)
            }
        }
        updateEditData()
    }
    
    func saveUserInfo(key: String,name: String = "",phone:String = "",relationKey: String = "",relationName: String = ""){
        guard !key.isEmpty else {return}
        guard (!name.isEmpty || !phone.isEmpty || !relationKey.isEmpty) else {return}
        var item: ContactsEditModel = .init()
        if let m = editData.first(where: {$0.satisfied == key}){
            item = m
        }
        item.satisfied = key
        if !name.isEmpty {
            item.nowadays = name
        }
        if !phone.isEmpty {
            item.belgian = phone
        }
        if !relationKey.isEmpty {
            item.foreigners = relationKey
            item.relation = relationName
        }
        if let index = editData.firstIndex(where: {$0.satisfied == item.satisfied}){
            editData.replaceSubrange(index ..< index + 1, with: [item])
        }else{
            editData.append(item)
        }
    }
    
    func updateEditData(){
        let array = self.itemList.map { model in
            let relationshipPlaceHolder = model.transferred
            let namePlaceHolder = model.several
            var name = model.nowadays
            var phoneNum = model.belgian
            var relationship = model.collaborated.first(where: {$0.general == model.foreigners})?.nowadays ?? ""
            if let item = editData.first(where: {$0.satisfied == model.satisfied}){
                name = item.nowadays
                phoneNum = item.belgian
                relationship = model.collaborated.first(where: {$0.general == item.foreigners})?.nowadays ?? ""
            }
            let relationModel = ProductInputView.Model.init(key: model.satisfied,content: relationship,placeHolder: relationshipPlaceHolder,isPicker: true,options: model.collaborated,pickCompletion: {[weak self] key, options in
                self?.eventDelegate?.showAlertView(title: model.gaze, key: key, options: options)
            })
            let nameStr = (!name.isEmpty && !phoneNum.isEmpty) ? "\(name)-\(phoneNum)" : ""
            let nameModel = ProductInputView.Model.init(key:model.satisfied,content: nameStr,placeHolder: namePlaceHolder, isPicker: true, pickCompletion:  {[weak self] key, _ in
                self?.currentKey = key
                self?.eventDelegate?.onPushContactsView()
            })
            return  ContactsListItemView.Model.init(title: model.rested,relationshipModel: relationModel,nameViewModel: nameModel)
        }
        dataSource = [UITableSectionModel.init(cellType: ContactsListCell.self,cellDatas: [ContactsListCell.Model(items: array)])]
    }
    
    func saveBasicInfo() async -> Bool{
        guard !editData.isEmpty else {return false}
        var paramas: [String: String] = [:]
        paramas["disappointed"] = productId
        var body: [[String: Any]] = []
        editData.forEach { model in
            var dic: [String: Any] = [:]
            dic["belgian"] = model.belgian
            dic["nowadays"] = model.nowadays
            dic["foreigners"] = model.foreigners
            dic["satisfied"] = model.satisfied
            body.append(dic)
        }
        paramas["howl"] = Data.objectToJSONString(paramas: body)
        let result: [String: Any]? = await HttpRequestDictionary(ProductAPI.saveContactsInfo(body: paramas),showLoading: true,showMessage: true)
        return result != nil
    }
}
