//
//  BaseViewController.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/12.
//

import UIKit

protocol BaseViewController where Self: UIViewController{
    var hiddenNavigationBar: Bool {set get}
}

extension BaseViewController{
    var hiddenNavigationBar: Bool {
        set{
            self.navigationController?.navigationBar.isHidden = newValue
        }
        get {
            return hiddenNavigationBar
        }
    }
}
