//
//  ProductListCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/22.
//

import UIKit
class ProductListCell: UITableViewCell {
    
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
    
    lazy var bgImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_product_item_bg")
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = kColor_black
        view.font = SLFont(size: 15,weight: .semibold)
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        let view = UILabel()
        view.textColor = kColor_7C7C7C
        view.font = SLFont(size: 11)
        view.numberOfLines = 0
        return view
    }()
    
    lazy var logoView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 22.ratio()
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = kColor_black
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = SLFont(size: 12, weight: .black)
        button.layer.cornerRadius = 15.ratio()
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        return button
    }()
}

extension ProductListCell{
    func setupUI(){
        backgroundColor = .clear
        contentView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16.ratio())
            make.bottom.equalToSuperview().inset(12.ratio())
        }
        bgImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18.ratio())
            make.leading.equalToSuperview().offset(68.ratio())
            make.trailing.lessThanOrEqualToSuperview().inset(110.ratio())
        }
        bgImageView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6.ratio())
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(20.ratio())
        }
        bgImageView.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(13.ratio())
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44.ratio())
        }
        bgImageView.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15.ratio())
            make.centerY.equalToSuperview()
            make.width.equalTo(88.ratio())
            make.height.equalTo(30.ratio())
        }
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        contentLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func applyModel(){
        titleLabel.text = model.title
        contentLabel.text = model.subTitle
        let buttonBgColor = model.isFinished ?  kColor_black : kColor_A7A7A7
        let buttonTitle = model.isFinished ? LocalizationConstants.Product.item_finish : LocalizationConstants.Product.item_unFinish
        let buttonTitleColor = model.isFinished ?  UIColor.white : kColor_5E5E5E
        nextButton.backgroundColor = buttonBgColor
        nextButton.setTitle(buttonTitle, for: .normal)
        nextButton.setTitleColor(buttonTitleColor, for: .normal)
        logoView.kf.setImage(with: URL(string: model.logo),placeholder: UIImage(named: model.type.imageName))
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
        self.model = model
    }
}

extension ProductListCell{
    struct Model {
        var title: String = ""
        var subTitle: String = ""
        var logo: String = ""
        var type: ProductItemType = .iDCard
        var isFinished: Bool = false
    }
}
