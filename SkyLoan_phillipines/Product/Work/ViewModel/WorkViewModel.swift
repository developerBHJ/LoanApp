//
//  WorkViewModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/28.
//

import Foundation

class WorkViewModel {
    var productId: String = ""
    var dataSource: [UITableSectionModel] = []
    var itemList: [PersonalBasicModel] = []
    var editData: [ProductEditItem] = []
    var eventDelegate: WorkInfoViewEventDelegate?
    var fullAddress: String = ""
    var cityName: String = ""
    var addressKey = "administered"
    
    func reloadData() async{
        guard !productId.isEmpty else {return}
        let result: [String: Any]? = await HttpRequestDictionary(ProductAPI.getWorkInfo(disappointed: productId))
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
//            let needSecond = (model.article == addressKey)
            let needSecond = false
            return  PersonalBasicInfoItemView.Model(title: model.feel,placeHolder: model.tea,content: content,keyBordType: model.clear,isPicker: model.bow != .text,key: model.article,options: model.definitely ?? [],needSecond: needSecond,secondPlaceHolder:LocalizationConstants.Product.fullAddressPlaceHolder, secondContent: fullAddress,valueChanged: {[weak self] key, value in
                self?.eventDelegate?.saveUserInfo(key: key, value: value)
            }, secondValueChanged: {[weak self] key, value in
                guard let self else {return}
                self.fullAddress = value
                self.saveUserInfo(item: .init(key: key,value: self.fullAddress + cityName))
            },pickCompletion:  {[weak self] options in
                self?.eventDelegate?.showAlertView(title: model.feel,key: model.article, options: options)
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
        let result: [String: Any]? = await HttpRequestDictionary(ProductAPI.saveWorkInfo(body: paramas),showLoading: true,showMessage: true)
        return result != nil
    }
}
