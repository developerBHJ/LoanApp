//
//  UITableViewAdapter.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/16.
//

import Foundation
import UIKit

protocol UITableViewAdapter {
    var cellType: UITableViewCell.Type {get set}
    var cellDatas: [Any]? {get set}
}
