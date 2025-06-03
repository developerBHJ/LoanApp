//
//  ProductViewModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/22.
//

import Foundation
import Alamofire

class ProductViewModel {
    var dataSource: [UITableSectionModel] = []
    var productId: String = ""
    var orderNum: String = ""
    var headerModel = ProductHomeHeaderView.Model()
    var detailModel: ProductDetailModel = .init()
    var eventDelegate: ProductHomeEventDelegate?
    var itemList: [ProductListModel] = []
    
    func reloadData() async{
        dataSource.removeAll()
        guard let list = await requestItemList() else {return}
        let isFinished = list.filter({$0.late == 1})
        headerModel = .init(current: isFinished.count,total: list.count,slogn: LocalizationConstants.Product.header_title)
        let model = configSectionData(list: list)
        dataSource = [model]
    }
    
    func requestItemList() async -> [ProductListModel]?{
        guard !productId.isEmpty else {return nil}
        let detailModel: ProductDetailModel = await HttpRequest(ProductAPI.getProductDetail(disappointed: productId),showLoading: true)
        self.detailModel = detailModel
        return detailModel.comrades
    }
    
    func configSectionData(list: [ProductListModel]) -> UITableSectionModel{
        itemList = list
        let dataArray = list.map { model in
            ProductListCell.Model.init(title: model.feel,subTitle: model.tea,logo: model.hot,type: model.fast,isFinished: model.late == 1)
        }
        return UITableSectionModel(cellType: ProductListCell.self,cellDatas: dataArray)
    }
    
    func getUrl() -> String?{
        guard detailModel.disdainful != 200,!detailModel.somehow.isEmpty else {return nil}
        let url = detailModel.somehow + "?" + PublicParamas().toURLStrings()
        return url
    }
    
    func apply() async -> String?{
        guard !productId.isEmpty else {return nil}
        let result: [String: Any]? = await HttpRequestDictionary(ProductAPI.apply(disappointed: productId),showLoading: true,showMessage: true)
        if let url = result?["somehow"] as? String{
            return url
        }
        return nil
    }
}
