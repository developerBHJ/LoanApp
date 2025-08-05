//
//  BaseCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/23.
//

import UIKit

class BaseCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
}

extension BaseCell{
    func setupUI(){
        
    }
    
    func applyModel(){
        
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
    }
}
extension BaseCell{
    struct Model {
        
    }
}

