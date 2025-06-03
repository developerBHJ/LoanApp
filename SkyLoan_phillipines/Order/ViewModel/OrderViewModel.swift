//
//  OrderViewModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/21.
//

import Foundation

@MainActor
class OrderViewModel {
    
    var dataSource: [UITableSectionModel] = []
    var enventDelegate: OrderViewEventDelegate?
    var orderType: Int = 4
    
    func reloadData() async{
        if let list = await requestOrderList(),!list.isEmpty{
            let orderList = list.compactMap({$0.persons})
            if !orderList.isEmpty{
                let sectionModel = configListItemSection(list: orderList)
                dataSource = [sectionModel]
            }
        }else{
            let model = configEmptySection()
            dataSource = [model]
        }
    }
    
    func requestOrderList() async -> [OrderListModel]?{
        let reslt: [String: Any]? = await HttpRequestDictionary(OrderAPI.orderList(present: "\(orderType)"),showLoading: true)
        var dataArray: [OrderListModel]?
        if let list = reslt?["trust"] as? [[String: Any]]{
            dataArray = OrderListModel.modelArray(from: list)
        }
        return dataArray
    }
    
    func configEmptySection() -> UITableSectionModel{
        let model = OrderListEmptyCell.Model(type: .empty,title: LocalizationConstants.Order.empty_title,content: LocalizationConstants.Order.empty_content,buttonTitle: LocalizationConstants.Order.empty_button) {
            [weak self] in
            self?.enventDelegate?.onPushApplyView()
        }
        return UITableSectionModel(cellType: OrderListEmptyCell.self,cellDatas: [model])
    }
    
    func configListItemSection(list: [PersonsModel]) -> UITableSectionModel{
        let dataArray = list.map { item in
            OrderListCell.Model(id: "\(item.awful)",title: item.fun,logo: item.pause,amount: item.necessity,amountDesc: item.witnesses,status: item.accident,statusDesc: item.morning,time: item.murderer,timeDesc: item.murderess,buttonTitle: item.inclosed,notice: item.mid,linkUrl: item.suicide){[weak self] url in
                self?.enventDelegate?.onPushOrderDetail(url: url)
            }
        }
        return UITableSectionModel(cellType: OrderListCell.self,cellDatas: dataArray)
    }
}
