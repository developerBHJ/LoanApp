//
//  HomePageProductListLargeCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/16.
//

import UIKit
class HomePageProductListLargeCell: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        applyModel()
    }
    
    init(frame: CGRect,model: Model = .init()) {
        super.init(frame: frame)
        self.model = model
        setupUI()
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_black
        label.font = SLFont(size: 15, weight: .black)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_B0ACA9
        label.font = SLFont(size: 11, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = kColor_black
        button.setImage(UIImage(named: "icon_next_white"), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = SLFont(size: 13, weight: .black)
        button.layer.cornerRadius = 15.ratio()
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonEvent), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var coverImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
}

extension HomePageProductListLargeCell{
    
    func setupUI(){
        backgroundColor = .white
        layer.cornerRadius = 12.ratio()
        layer.masksToBounds = true
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(nextButton)
        addSubview(coverImage)
        NSLayoutConstraint.activate([
            coverImage.topAnchor.constraint(equalTo: topAnchor),
            coverImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            coverImage.widthAnchor.constraint(equalToConstant: 110.ratio()),
            coverImage.heightAnchor.constraint(equalToConstant: 125.ratio()),
            coverImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.ratio()),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.ratio()),
            titleLabel.trailingAnchor.constraint(equalTo: coverImage.leadingAnchor, constant: -4.ratio()),
            
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13.ratio()),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.ratio()),
            nextButton.widthAnchor.constraint(equalToConstant: 120.ratio()),
            nextButton.heightAnchor.constraint(equalToConstant: 30.ratio()),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.ratio()),
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            contentLabel.bottomAnchor.constraint(lessThanOrEqualTo: nextButton.topAnchor,constant: -10.ratio()),
        ])
        self.addTarget(action: #selector(buttonEvent))
    }
    
    func applyModel(){
        titleLabel.text = model.title
        contentLabel.text = model.content
        nextButton.setTitle(model.buttonTitle, for: .normal)
        coverImage.kf.setImage(with: URL(string: model.imageUrl))
        nextButton.layoutImagePositionType(type: .right,spacing: 8.ratio())
    }
    
    @objc func buttonEvent(){
        model.buttonTapClosure?(model.linkUrl)
    }
}

extension HomePageProductListLargeCell{
    struct Model {
        var id: String = ""
        var title: String = ""
        var content: String = ""
        var buttonTitle: String = ""
        var imageUrl: String = ""
        var linkUrl: String = ""
        var buttonTapClosure: ((String) -> Void)? = nil
    }
}
