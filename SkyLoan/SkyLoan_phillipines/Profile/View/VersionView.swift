//
//  VersionView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/14.
//

import UIKit

class VersionView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        applyModel()
    }
    
    init(frame: CGRect,model: Model) {
        super.init(frame: frame)
        setUI()
        self.model = model
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_black
        label.font = SLFont(size: 16, weight: .black)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_5B5B5B
        label.font = SLFont(size: 16, weight: .semibold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
}

extension VersionView{
    func setUI(){
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 4.ratio()),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        self.addTarget(action: #selector(tapEvent))
    }
    
    func applyModel(){
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
    }
    
   @objc func tapEvent(){
       SLProgressHUD.showToast(message: "Current Version \(model.title)")
    }
}

extension VersionView{
    struct Model {
        var title: String = "\(appVersion)"
        let subTitle: String = LocalizationConstants.Profile.profile_version
    }
}
