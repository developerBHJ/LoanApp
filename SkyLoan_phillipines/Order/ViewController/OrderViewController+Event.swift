//
//  OrderViewController+Event.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/22.
//

import Foundation

protocol OrderViewEventDelegate{
    func onPushApplyView()
    func refreshData(type: Int)
    func onPushOrderDetail(url: String)
}

extension OrderViewController: OrderViewEventDelegate{
    func onPushApplyView() {
        RouteManager.shared.routeTo("blue://sky.yes.app/octopusTarra")
    }
    
    func refreshData(type: Int) {
        viewModel.orderType = type
        reloadData()
    }
    
    func onPushOrderDetail(url: String) {
        RouteManager.shared.routeTo(url)
    }
}
