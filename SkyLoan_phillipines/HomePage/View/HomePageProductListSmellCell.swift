//
//  HomePageProductListSmellCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/19.
//

import UIKit

class HomePageProductListSmellCell: UIView {
    
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
        label.textColor = UIColor.white
        label.font = SLFont(size: 11, weight: .black)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = kColor_black
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
        view.backgroundColor = .white
        view.layer.cornerRadius = 42.5.ratio() / 2
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var bgImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "icon_home_product_item_bg")
        view.clipsToBounds = true
        return view
    }()
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
}

extension HomePageProductListSmellCell{
    
    func setupUI(){
        backgroundColor = .clear
        addSubview(bgImage)
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(nextButton)
        addSubview(coverImage)
        NSLayoutConstraint.activate([
            bgImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgImage.topAnchor.constraint(equalTo: topAnchor),
            bgImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgImage.heightAnchor.constraint(equalToConstant: 95.ratio()),
            
            nextButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.ratio()),
            nextButton.widthAnchor.constraint(equalToConstant: 88.ratio()),
            nextButton.heightAnchor.constraint(equalToConstant: 30.ratio()),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 26.ratio()),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 63.5.ratio()),
            titleLabel.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor, constant: -10.ratio()),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6.ratio()),
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            coverImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            coverImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 13.ratio()),
            coverImage.widthAnchor.constraint(equalToConstant: 42.5.ratio()),
            coverImage.heightAnchor.constraint(equalToConstant: 42.5.ratio()),
        ])
        self.addTarget(action: #selector(buttonEvent))
    }
    
    func applyModel(){
        titleLabel.text = model.title
        contentLabel.text = model.content
        nextButton.setTitle(model.buttonTitle, for: .normal)
        coverImage.kf.setImage(with: URL(string: model.imageUrl))
    }
    
    @objc func buttonEvent(){
        model.buttonTapClosure?(model.id)
    }
}

extension HomePageProductListSmellCell{
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

