//
//  UIStackView+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/14.
//

import UIKit
extension UIStackView{
    
    func addSubViews(views: [UIView]){
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
    
    func removeAllSubViews(){
        subviews.forEach { view in
            removeArrangedSubview(view)
        }
    }
}
