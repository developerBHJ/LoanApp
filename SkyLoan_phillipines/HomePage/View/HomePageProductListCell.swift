//
//  HomePageProductListCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/16.
//

import UIKit
import SnapKit

class HomePageProductListCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_home_product_large")?.resizableImage(withCapInsets: .init(top: 50, left: 0, bottom: 20, right: 0))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
}

extension HomePageProductListCell{
    func setupUI(){
        backgroundColor = .clear
        contentView.addSubview(bgImageView)
        contentView.addSubview(contentBgView)
        contentBgView.addSubview(headerImageView)
        contentBgView.addSubview(stackView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(19.ratio())
            make.trailing.equalToSuperview().inset(19.ratio())
        }
        
        contentBgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(21.ratio())
            make.leading.equalToSuperview().inset(35.ratio())
            make.trailing.equalToSuperview().inset(35.ratio())
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
            let view = HomePageProductListLargeCell(frame: .zero, model: .init(id:"\(model.confidential)",title: model.fun,content: model.friends,buttonTitle: model.night,imageUrl: model.pause,linkUrl: model.somehow,buttonTapClosure: {[weak self] url in
                self?.model.tapClosure?("\(model.confidential)")
            }))
            view.snp.makeConstraints { make in
                make.width.equalTo(kScreenW - 70.ratio())
                make.height.greaterThanOrEqualTo(125.ratio())
            }
            return view
        })
        stackView.addSubViews(views: subViews)
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
        self.model = model
    }
}

extension HomePageProductListCell{
    struct Model {
        var isLarge: Bool = false
        var items: [HomeProductModel] = []
        var tapClosure: ((String) -> Void)? = nil
        var productEvent:((String) -> Void)? = nil
    }
}
