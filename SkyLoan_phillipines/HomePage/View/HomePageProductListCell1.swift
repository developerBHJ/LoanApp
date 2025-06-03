//
//  HomePageProductListCell1.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/23.
//

import UIKit
import SnapKit

class HomePageProductListCell1: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var headerImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_home_product_title")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentBgView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 13.ratio()
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    var model: HomePageProductListCell.Model = .init(){
        didSet{
            applyModel()
        }
    }
}

extension HomePageProductListCell1{
    func setupUI(){
        backgroundColor = .clear
        contentView.addSubview(contentBgView)
        contentBgView.addSubview(headerImageView)
        contentBgView.addSubview(stackView)
        
        contentBgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(21.ratio())
            make.leading.equalToSuperview().inset(16.ratio())
            make.trailing.equalToSuperview().inset(16.ratio())
        }
        
        headerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16.ratio())
            make.leading.equalToSuperview()
            make.height.equalTo(42.ratio())
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(headerImageView.snp.bottom).offset(22.ratio())
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func applyModel(){
        configItems()
    }
    
    func configItems(){
        stackView.removeAllSubViews()
        var subViews: [UIView]
        subViews = model.items.map({ model in
            let subTitle = "Loan Amount：₱ \(model.eyebrows)"
            let view = HomePageProductListSmellCell.init(frame: .zero, model: .init(id:"\(model.confidential)",title: model.fun,content: subTitle,buttonTitle: model.night,imageUrl: model.pause,linkUrl: model.somehow,buttonTapClosure: {[weak self] id in
                self?.model.productEvent?(id)
            }))
            view.snp.makeConstraints { make in
                make.width.equalTo(kScreenW - 32.ratio())
                make.height.greaterThanOrEqualTo(95.ratio())
            }
            return view
        })
        stackView.addSubViews(views: subViews)
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    override func configData(data: Any?) {
        guard let model = data as? HomePageProductListCell.Model else {return}
        self.model = model
    }
}
