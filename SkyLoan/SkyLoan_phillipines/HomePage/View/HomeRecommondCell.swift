//
//  HomeRecommondCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/16.
//

import UIKit
import FSPagerView

class HomeRecommondCell: FSPagerViewCell {
    
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
    
    lazy var contentBgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12.ratio()
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(buttonEvent), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "icon_home_next"), for: .normal)
        return button
    }()
    
    lazy var noticeImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_home_notice")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_black
        label.font = SLFont(size: 13, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
}

extension HomeRecommondCell{
    func setupUI(){
        backgroundColor = .clear
        addSubview(contentBgView)
        contentBgView.addSubview(noticeImageView)
        contentBgView.addSubview(contentLabel)
        contentBgView.addSubview(rightButton)
        NSLayoutConstraint.activate([
            contentBgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentBgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.ratio()),
            contentBgView.widthAnchor.constraint(equalToConstant: kScreenW - 32.ratio()),
            contentBgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: contentBgView.topAnchor, constant: 14.ratio()),
            contentLabel.leadingAnchor.constraint(equalTo: contentBgView.leadingAnchor, constant: 55.ratio()),
            contentLabel.trailingAnchor.constraint(equalTo: contentBgView.trailingAnchor, constant: -72.ratio()),
            contentLabel.bottomAnchor.constraint(equalTo: contentBgView.bottomAnchor,constant: -14.ratio()),
            
            noticeImageView.centerYAnchor.constraint(equalTo: contentBgView.centerYAnchor),
            noticeImageView.leadingAnchor.constraint(equalTo: contentBgView.leadingAnchor, constant: 14.ratio()),
            noticeImageView.widthAnchor.constraint(equalToConstant: 28.5.ratio()),
            noticeImageView.heightAnchor.constraint(equalToConstant: 26.ratio()),
            
            rightButton.centerYAnchor.constraint(equalTo: contentBgView.centerYAnchor),
            rightButton.trailingAnchor.constraint(equalTo: contentBgView.trailingAnchor, constant: -15.ratio()),
            rightButton.widthAnchor.constraint(equalToConstant: 26.ratio()),
            rightButton.heightAnchor.constraint(equalToConstant: 26.ratio()),
        ])
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(buttonEvent))
        contentBgView.addGestureRecognizer(tapGR)
    }
    
    func applyModel(){
        contentLabel.text = model.content
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    @objc func buttonEvent(){
        model.tapClosure?(model.linkUrl)
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
        self.model = model
    }
}

extension HomeRecommondCell{
    struct Model {
        var content: String = ""
        var linkUrl: String = ""
        var tapClosure: ((String)->Void)? = nil
    }
}
