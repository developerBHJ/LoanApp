//
//  PersonalBasicHeaderView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/27.
//

import UIKit

class PersonalBasicHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    lazy var logoView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_black
        label.font = SLFont(size: 15, weight: .semibold)
        return label
    }()
    
    lazy var progressBar: CapsuleProgressBar = {
        let view = CapsuleProgressBar(frame: .zero,model: .init())
        return view
    }()
}

extension PersonalBasicHeaderView{
    func setupUI(){
        backgroundColor = .clear
        addSubview(bgImageView)
        bgImageView.addSubview(logoView)
        bgImageView.addSubview(titleLabel)
        bgImageView.addSubview(progressBar)
        bgImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20.ratio())
            make.leading.trailing.equalToSuperview().inset(16.ratio())
            make.height.equalTo(77.ratio())
        }
        logoView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12.ratio())
            make.width.height.equalTo(42.5.ratio())
        }
        progressBar.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(12.ratio())
            make.width.equalTo(90.ratio())
            make.height.equalTo(30.ratio())
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(logoView.snp.trailing).offset(17.ratio())
            make.trailing.equalTo(progressBar.snp.leading).offset(-10.ratio())
        }
    }
    
    func applyModel(){
        titleLabel.text = model.title
        logoView.image = UIImage(named: model.imageName)
        progressBar.model = .init(current: model.current,total: model.total,cornerRadius: 8.ratio(), textColor: kColor_black)
    }
}

extension PersonalBasicHeaderView{
    struct Model {
        var title: String = ""
        var imageName: String = ""
        var current: Int = 0
        var total: Int = 0
    }
}
