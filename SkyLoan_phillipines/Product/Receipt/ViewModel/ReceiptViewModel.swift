//
//  ReceiptViewModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/29.
//

import Foundation

class ReceiptViewModel{
    var productId: String = ""
    var dataSource: [UITableSectionModel] = []
    var itemList: [ReceiptListModel] = []
    var editData: [ProductEditItem] = []
    var eventDelegate: ReceiptViewEventDelegate?
    var selectedType: ReceiptBankType = .e_wallet
    var currentList: [PersonalBasicModel] = []
    private var segementTitles: [String] = []
    private var segementRawValues: [Int] = []
    var selectedAddress: String = ""
    
    func reloadData() async{
        guard !productId.isEmpty else {return}
        let result: [String: Any]? = await HttpRequestDictionary(ProductAPI.getBankInfo(wilson: "0"))
        guard let list = result?["stared"] as? [[String: Any]] else {return}
        let modelList = ReceiptListModel.modelArray(from: list)
        self.itemList = modelList
        configSections(list: modelList)
    }
    
    func configSections(list: [ReceiptListModel]){
        guard !list.isEmpty else {return}
        segementTitles = list.map({$0.feel})
        segementRawValues = list.map({$0.general.rawValue})
        updateEditData()
    }
    
    func updateEditData(){
        guard let dataArray = itemList.first(where: {$0.general == selectedType})?.stared,!dataArray.isEmpty else {return}
        self.currentList = dataArray
        let items = dataArray.map { item in
            let content = editData.first(where: {$0.key == item.article})?.value ?? item.laughed
            if !item.laughed.isEmpty{
                let item = ProductEditItem.init(key: item.article,value: item.laughed,general: item.general)
                self.saveUserInfo(item: item)
            }
            return ReceiptListItemView.Model.init(title: item.feel,nameViewModel: .init(key: item.article,content: content,placeHolder: item.feel,isPicker: item.bow != .text,keyBordType: item.clear,options: item.definitely ?? [],valueChanged: {[weak self] key, value in
                let item = ProductEditItem.init(key: key,value: value)
                self?.saveUserInfo(item: item)
            },pickCompletion: {[weak self] key, options in
                self?.eventDelegate?.showAlertView(isAddress: item.bow == .citySelect,title: item.feel, key: key, options: options)
            }))
        }
        let cellModel = ReceiptListCell.Model.init(items: items,segements: segementTitles,segementType: segementRawValues,currentIndex: selectedType.rawValue - 1) {[weak self] type in
            self?.selectedType = ReceiptBankType.init(rawValue: type) ?? .e_wallet
            self?.editData = []
            self?.eventDelegate?.refreshData()
        }
        dataSource = [UITableSectionModel.init(cellType: ReceiptListCell.self,cellDatas: [cellModel])]
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
    
    func saveBasicInfo() async -> Bool{
        guard !editData.isEmpty else {return false}
        var paramas: [String: String] = [:]
        paramas["disappointed"] = productId
        paramas["less"] = "\(selectedType.rawValue)"
        editData.forEach { item in
            if !item.general.isEmpty{
                paramas[item.key] = item.general
            }else{
                paramas[item.key] = item.value
            }
        }
        let result: [String: Any]? = await HttpRequestDictionary(ProductAPI.saveBankInfo(body: paramas),showLoading: true,showMessage: true)
        return result != nil
    }
}
