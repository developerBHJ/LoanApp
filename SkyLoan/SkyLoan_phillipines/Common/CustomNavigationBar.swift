//
//  CustomNavigationBar.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/21.
//

import UIKit

class CustomNavigationBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_back"), for: .normal)
        button.addTarget(self, action: #selector(backEvent), for: .touchUpInside)
        button.hitTestEdgeInsets = .init(top: -10, left: -10, bottom: -10, right: -10)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_black
        label.font = SLFont(size: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    var title: String = "" {
        willSet{
            titleLabel.text = newValue
        }
    }
}

extension CustomNavigationBar{
    func setupUI(){
        backgroundColor = .clear
        addSubview(titleLabel)
        addSubview(backButton)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(kStatusBarH + 12.ratio())
            make.bottom.equalToSuperview().inset(12.ratio())
            make.centerX.equalToSuperview()
        }
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalToSuperview().inset(14.ratio())
            make.width.height.equalTo(22.5.ratio())
        }
    }
    
    @objc func backEvent(){
        UIViewController.topMost?.popNavigation()
    }
}
