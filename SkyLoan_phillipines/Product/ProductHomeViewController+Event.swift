//
//  ProductHomeViewController+Event.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/23.
//

import Foundation
import UIKit

protocol ProductHomeEventDelegate{
    func itemClick(model: ProductListModel)
}

extension ProductHomeViewController: ProductHomeEventDelegate{
    
    @MainActor
    override func nextEvent() {
        Task{
            ProductEntrance.shared.onPushAuthenView()
        }
    }
    
    func itemClick(model: ProductListModel){
        if model.late == 1{
            ProductEntrance.shared.onPushAuthenView(type: model.fast)
        }else{
            ProductEntrance.shared.onPushAuthenView()
        }
    }
}
