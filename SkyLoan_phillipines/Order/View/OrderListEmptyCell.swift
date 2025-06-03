//
//  OrderListEmptyCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/21.
//

import UIKit

class OrderListEmptyCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var contentBgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25.ratio()
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var emptyImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_order_empty")
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(kColor_black, for: .normal)
        button.titleLabel?.font = SLFont(size: 15, weight: .black)
        button.layer.cornerRadius = 15.ratio()
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonEvent), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "icon_alert_button"), for: .normal)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_black
        label.font = SLFont(size: 15, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_959595
        label.font = SLFont(size: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
}

extension OrderListEmptyCell{
    func setupUI(){
        backgroundColor = .clear
        contentView.addSubview(contentBgView)
        contentBgView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16.ratio())
        }
        contentBgView.addSubview(emptyImageView)
        emptyImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90.ratio())
            make.centerX.equalToSuperview()
            make.width.equalTo(155.ratio())
            make.height.equalTo(118.ratio())
        }
        
        contentBgView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(50.ratio())
            make.leading.trailing.equalToSuperview().inset(38.ratio())
        }
        
        contentBgView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12.ratio())
            make.leading.trailing.equalToSuperview().inset(38.ratio())
        }
        
        contentBgView.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(26.ratio())
            make.centerX.equalToSuperview()
            make.width.equalTo(134.ratio())
            make.height.equalTo(46.ratio())
            make.bottom.equalToSuperview().inset(104.ratio())
        }
    }
    
    func applyModel(){
        emptyImageView.image = UIImage.init(named: model.type.image)
        titleLabel.text = model.title
        contentLabel.text = model.content
        nextButton.setTitle(model.buttonTitle, for: .normal)
        let imageWidth = model.type == .empty ? 155.ratio(): 178.ratio()
        let imageHeight = model.type == .empty ? 118.ratio(): 113.ratio()
        emptyImageView.snp.updateConstraints { make in
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageHeight)
        }
        let topSpace = model.type == .empty ? 50.ratio(): 53.ratio()
        titleLabel.snp.updateConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(topSpace)
        }
    }
    
    @objc func buttonEvent(){
        model.buttonCompletion?()
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
        self.model = model
    }
}
extension OrderListEmptyCell{
    enum EmptyType {
        case empty
        case noNet
    }
    
    struct Model {
        var type: EmptyType = .empty
        var title: String = ""
        var content: String = ""
        var buttonTitle: String = ""
        var buttonCompletion: (() -> Void)? = nil
    }
}

extension OrderListEmptyCell.EmptyType{
    var image: String {
        switch self {
        case .empty:
            "icon_order_empty"
        case .noNet:
            "icon_order_net"
        }
    }
}

