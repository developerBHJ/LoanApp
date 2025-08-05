//
//  HomePageSectionModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/16.
//

import UIKit
struct UITableSectionModel: UITableViewAdapter{
    var cellType: UITableViewCell.Type = HomeBannerCell.self
    var cellDatas: [Any]? = nil
}
