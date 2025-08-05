//
//  ProfileListItem.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/14.
//

import UIKit

class ProfileListItem: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        applyModel()
    }
    
    init(frame: CGRect,model: Model) {
        super.init(frame: frame)
        setupUI()
        self.model = model
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
    
    var contentLeadingConstraint: NSLayoutConstraint?
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var rightImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = kColor_black
        view.font = SLFont(size: 16, weight: .black)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

extension ProfileListItem{
    func setupUI(){
        addSubview(contentView)
        contentView.addSubview(leftImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightImageView)
        contentLeadingConstraint = contentView.leadingAnchor.constraint(equalTo: leadingAnchor)
        
        if let leadingConstraint = contentLeadingConstraint {
            NSLayoutConstraint.activate([
                leadingConstraint,
                contentView.topAnchor.constraint(equalTo: topAnchor),
                contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                leftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                leftImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                leftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                leftImageView.widthAnchor.constraint(equalToConstant: 47.5.ratio()),
                leftImageView.heightAnchor.constraint(equalToConstant: 42.ratio()),
                
                rightImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                rightImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                rightImageView.widthAnchor.constraint(equalToConstant: 20.5.ratio()),
                rightImageView.heightAnchor.constraint(equalToConstant: 20.5.ratio()),
                
                titleLabel.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor,constant: 12.ratio()),
                titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: rightImageView.leadingAnchor, constant: -10.ratio()),
            ])
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapEvent))
            contentView.addGestureRecognizer(tapGR)
        }
    }
    
    func applyModel(){
        if let icon = model.icon{
            leftImageView.isHidden = false
            leftImageView.image = UIImage(named: icon)
        }else{
            leftImageView.isHidden = true
        }
        titleLabel.text = model.title
        rightImageView.image = UIImage(named: model.rightArrow)
        titleLabel.textColor = model.textColor
        contentLeadingConstraint?.constant = model.originX
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    @objc func tapEvent(){
        model.tapCompletion?(model.type)
    }
}

extension ProfileListItem{
    struct Model {
        var title: String = ""
        var icon: String? = nil
        var originX: CGFloat = 0
        var linkUrl: String = ""
        var rightArrow: String = "icon_profile_arrow"
        var textColor: UIColor = kColor_black
        var type: ProfileListType = .order
        var tapCompletion: ((ProfileListType) -> Void)? = nil
    }
}
