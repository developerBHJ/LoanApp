//
//  PersonalInfoViewModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/27.
//

import Foundation

class PersonalInfoViewModel {
    var productId: String = ""
    var dataSource: [UITableSectionModel] = []
    var itemList: [PersonalBasicModel] = []
    var editData: [ProductEditItem] = []
    var eventDelegate: PersonalInfoViewEventDelegate?
    var selectedProvince: String = ""
    var selectedCity: String = ""
    var selectedStreet: String = ""
    var nextStep: Int = 0
    
    func reloadData() async{
        guard !productId.isEmpty else {return}
        let result: [String: Any]? = await HttpRequestDictionary(ProductAPI.getBasicInfo(disappointed: productId))
        guard let list = result?["stared"] as? [[String: Any]] else {return}
        let modelList = PersonalBasicModel.modelArray(from: list)
        self.itemList = modelList
        configSections(list: modelList)
    }
    
    func configSections(list: [PersonalBasicModel]){
        guard !list.isEmpty else {return}
        list.forEach { model in
            if !model.laughed.isEmpty{
                let item = ProductEditItem.init(key: model.article,value: model.laughed,general: model.general)
                saveUserInfo(item: item)
            }
        }
        updateEditData()
    }
    
    func saveUserInfo(item: ProductEditItem){
        guard !item.key.isEmpty else {return}
        if item.value.isEmpty {
            guard let index = editData.firstIndex(where: {$0.key == item.key}) else {return}
            editData.remove(at: index)
        }else{
            if let index = editData.firstIndex(where: {$0.key == item.key}){
                editData.replaceSubrange(index ..< index + 1, with: [item])
            }else{
                editData.append(item)
            }
        }
    }
    
    func updateEditData(){
        let array = self.itemList.map { model in
            let content = editData.first(where: {$0.key == model.article})?.value ?? ""
            return  PersonalBasicInfoItemView.Model(title: model.feel,placeHolder: model.tea,content: content,keyBordType: model.clear,isPicker: model.bow != .text,key: model.article,options: model.definitely ?? [], valueChanged: {[weak self] key, value in
                self?.eventDelegate?.saveUserInfo(key: key, value: value)
            },pickCompletion:  {[weak self] options in
                self?.eventDelegate?.showAlertView(isAddress:model.bow == .citySelect,title: model.feel,key: model.article, options: options)
            })
        }
        dataSource = [UITableSectionModel.init(cellType: PersonalBasicInfoCell.self,cellDatas: [PersonalBasicInfoCell.Model(items: array)])]
    }
    
    func saveBasicInfo() async -> Bool{
        guard !editData.isEmpty else {return false}
        var paramas: [String: String] = [:]
        paramas["disappointed"] = productId
        editData.forEach { item in
            if !item.general.isEmpty{
                paramas[item.key] = item.general
            }else{
                paramas[item.key] = item.value
            }
        }
        let result: [String: Any]? = await HttpRequestDictionary(ProductAPI.saveBasicInfo(body: paramas),showLoading: true,showMessage: true)
        return result != nil
    }
}
