//
//  HomeKingKongCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/16.
//

import UIKit
class HomeKingKongCell: UITableViewCell {
    
    lazy var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
        button.tag = 1000
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(kColor_wihte, for: .normal)
        button.titleLabel?.font = SLFont(size: 12, weight: .semibold)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    lazy var middleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
        button.tag = 1001
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(kColor_black, for: .normal)
        button.titleLabel?.font = SLFont(size: 19, weight: .black)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
        button.tag = 1002
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(kColor_wihte, for: .normal)
        button.titleLabel?.font = SLFont(size: 12, weight: .semibold)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    lazy var thumbImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "icon_home_thumb")
        return view
    }()
    
    var bottomConstraint: NSLayoutConstraint?
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeKingKongCell{
    func setupUI(){
        backgroundColor = .clear
        contentView.addSubview(leftButton)
        contentView.addSubview(middleButton)
        contentView.addSubview(rightButton)
        contentView.addSubview(thumbImageView)
        bottomConstraint = middleButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -40.ratio())
        if let bottomConstraint = bottomConstraint{
            NSLayoutConstraint.activate([
                middleButton.topAnchor.constraint(equalTo: contentView.topAnchor),
                middleButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                middleButton.heightAnchor.constraint(equalToConstant: 75.ratio()),
                bottomConstraint,
                
                leftButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.ratio()),
                leftButton.centerYAnchor.constraint(equalTo: middleButton.centerYAnchor),
                leftButton.widthAnchor.constraint(equalToConstant: 80.ratio()),
                leftButton.heightAnchor.constraint(equalToConstant: 59.ratio()),
                leftButton.trailingAnchor.constraint(equalTo: middleButton.leadingAnchor, constant: -12.ratio()),
                
                rightButton.leadingAnchor.constraint(equalTo: middleButton.trailingAnchor, constant: 12.ratio()),
                rightButton.centerYAnchor.constraint(equalTo: middleButton.centerYAnchor),
                rightButton.widthAnchor.constraint(equalToConstant: 80.ratio()),
                rightButton.heightAnchor.constraint(equalToConstant: 59.ratio()),
                rightButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.ratio()),
                
                thumbImageView.centerYAnchor.constraint(equalTo: middleButton.bottomAnchor),
                thumbImageView.centerXAnchor.constraint(equalTo: middleButton.trailingAnchor),
                thumbImageView.widthAnchor.constraint(equalToConstant: 62.ratio()),
                thumbImageView.heightAnchor.constraint(equalToConstant: 55.5.ratio()),
            ])
        }
    }
    
    func applyModel(){
        leftButton.setAttributedTitle(model.leftButtonTitle.addUnderline(), for: .normal)
        leftButton.setBackgroundImage(UIImage(named: model.leftButtonIcon), for: .normal)
        middleButton.setTitle(model.middleButtonTitle, for: .normal)
        middleButton.setBackgroundImage(UIImage(named: model.middleButtonIcon), for: .normal)
        rightButton.setAttributedTitle(model.rightButtonTitle.addUnderline(), for: .normal)
        rightButton.setBackgroundImage(UIImage(named: model.rightButtonIcon), for: .normal)
        thumbImageView.isHidden = model.hideThumb
        let bottomSpace = model.hideThumb ? 15.ratio() : 40.ratio()
        bottomConstraint?.constant = CGFloat(-bottomSpace)
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    @objc func buttonEvent(sender: UIButton){
        let tag = sender.tag - 1000
        let type = ButtonType.init(rawValue: tag)
        model.eventClosure?(type ?? .condition)
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
        self.model = model
    }
}

extension HomeKingKongCell{
    enum ButtonType: Int {
        case condition = 0
        case detail
        case contact
    }
    
    struct Model {
        var leftButtonTitle: String = ""
        var middleButtonTitle: String = ""
        var rightButtonTitle: String = ""
        var leftButtonIcon: String = ""
        var middleButtonIcon: String = ""
        var rightButtonIcon: String = ""
        var hideThumb: Bool = false
        var eventClosure: ((ButtonType) -> Void)? = nil
    }
}
