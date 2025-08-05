//
//  IDCardCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/23.
//

import UIKit

class IDCardCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
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
        view.image = UIImage(named: "icon_idCard_bg")
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var exampleImageView: UIButton = {
        let view = UIButton.init(type: .custom)
        view.setBackgroundImage(UIImage(named: "icon_product_example"), for: .normal)
        view.addTarget(self, action: #selector(tapEvent), for: .touchUpInside)
        view.layer.cornerRadius = 8.ratio()
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var tipsView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(tipsImageView)
        view.addSubview(tipsLabel)
        tipsImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.height.equalTo(22.ratio())
        }
        tipsLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(tipsImageView.snp.trailing).offset(25.ratio())
            make.trailing.equalToSuperview()
        }
        return view
    }()
    
    lazy var tipsImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_product_idCard")
        return view
    }()
    
    lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.font = SLFont(size: 14, weight: .semibold)
        label.textColor = kColor_black
        return label
    }()
    
    lazy var noticeTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_black
        label.font = SLFont(size: 13, weight: .black)
        label.textAlignment = .center
        return label
    }()
    
    lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_black.withAlphaComponent(0.3)
        label.font = SLFont(size: 11, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var stackView: UIStackView = UIStackView()
}

extension IDCardCell{
    func setupUI(){
        backgroundColor = .clear
        contentView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16.ratio())
            make.top.bottom.equalToSuperview()
        }
        bgImageView.addSubview(exampleImageView)
        exampleImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16.ratio())
            make.leading.trailing.equalToSuperview().inset(28.ratio())
            make.height.equalTo(153.ratio())
        }
        bgImageView.addSubview(tipsView)
        tipsView.snp.makeConstraints { make in
            make.top.equalTo(exampleImageView.snp.bottom).offset(19.ratio())
            make.centerX.equalToSuperview()
            make.height.equalTo(22.ratio())
        }
        bgImageView.addSubview(noticeTitleLabel)
        noticeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(tipsView.snp.bottom).offset(14.ratio())
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(18.ratio())
        }
        bgImageView.addSubview(noticeLabel)
        noticeLabel.snp.makeConstraints { make in
            make.top.equalTo(noticeTitleLabel.snp.bottom).offset(9.ratio())
            make.leading.trailing.equalToSuperview().inset(44.ratio())
        }
        tipsLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        noticeLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func applyModel(){
        exampleImageView.setBackgroundImage(model.image, for: .normal)
        tipsLabel.text = model.tips
        noticeTitleLabel.text = "—— " + model.noticeTitle + " ——"
        noticeLabel.text = model.notice
        stackView.removeFromSuperview()
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12.ratio()
        stackView.distribution = .fill
        stackView.alignment = .fill
        bgImageView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(noticeLabel.snp.bottom).offset(17.ratio())
            make.leading.trailing.equalToSuperview().inset(64.ratio())
            make.height.equalTo(40.ratio())
            make.bottom.equalToSuperview().inset(32.ratio())
        }
        let itemViews = model.items.map { image in
            let view = creatItemView(imageName: image)
            view.snp.makeConstraints { make in
                make.width.equalTo(66.ratio())
                make.height.equalTo(46.ratio())
            }
            return view
        }
        stackView.addSubViews(views: itemViews)
    }
    
    func creatItemView(imageName: String)-> UIView{
        let view = UIView()
        view.backgroundColor = .clear
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(6.ratio())
        }
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = kColor_FF0000
        label.layer.cornerRadius = 6.5.ratio()
        label.layer.masksToBounds = true
        label.text = "X"
        label.font = SLFont(size: 9, weight: .semibold)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.bottom.centerX.equalToSuperview()
            make.width.height.equalTo(13.ratio())
        }
        return view
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
        self.model = model
    }
    
    @objc func tapEvent(){
        model.tapCompletion?()
    }
}
extension IDCardCell{
    struct Model {
        var image: UIImage? = nil
        var tips: String = ""
        var noticeTitle: String = ""
        var notice: String = ""
        var items: [String] = []
        var tapCompletion: (()-> Void)? = nil
    }
}
