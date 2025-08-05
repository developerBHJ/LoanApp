//
//  IDCardAuthenTypeCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/25.
//

import UIKit
class IDCardAuthenTypeCell: UITableViewCell {
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
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10.ratio()
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_black
        label.font = SLFont(size: 13)
        return label
    }()
    
    lazy var selectedButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_product_select_normal"), for: .normal)
        button.setImage(UIImage(named: "icon_product_select_sel"), for: .highlighted)
        button.setImage(UIImage(named: "icon_product_select_sel"), for: .selected)
        button.setBackgroundImage(UIImage(named: "icon_product_select_bg_normal"), for: .normal)
        button.setBackgroundImage(UIImage(named: "icon_product_select_bg"), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "icon_product_select_bg"), for: .selected)
        button.isUserInteractionEnabled = false
        return button
    }()
}

extension IDCardAuthenTypeCell{
    func setupUI(){
        backgroundColor = .clear
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(9.ratio())
            make.height.equalTo(43.ratio())
        }
        bgView.addSubview(contentLabel)
        bgView.addSubview(selectedButton)
        contentLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(16.ratio())
            make.trailing.equalToSuperview()
        }
        selectedButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16.ratio())
            make.width.height.equalTo(20.ratio())
        }
    }
    
    func applyModel(){
        contentLabel.text = model.title
        selectedButton.isSelected = model.isSelected
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
        self.model = model
    }
}
extension IDCardAuthenTypeCell{
    struct Model {
        var title: String = ""
        var isSelected: Bool = false
    }
}



