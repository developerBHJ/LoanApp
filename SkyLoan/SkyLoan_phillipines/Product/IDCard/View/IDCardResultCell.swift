//
//  IDCardResultCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/25.
//

import UIKit
class IDCardResultCell: UITableViewCell {
    
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
    
    lazy var idCardImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_idCard_result")
        view.layer.cornerRadius = 8.ratio()
        view.layer.masksToBounds = true
        let successImageView = UIImageView()
        successImageView.image = UIImage(named: "icon_idCard_success")
        view.addSubview(successImageView)
        successImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(30.ratio())
        }
        return view
    }()
    
    lazy var faceImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_face_result")
        view.backgroundColor = .white
        view.layer.cornerRadius = 8.ratio()
        view.layer.masksToBounds = true
        let successImageView = UIImageView()
        successImageView.image = UIImage(named: "icon_idCard_success")
        view.addSubview(successImageView)
        successImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(30.ratio())
        }
        return view
    }()
    
    var stackView: UIStackView = UIStackView()
}

extension IDCardResultCell{
    func setupUI(){
        backgroundColor = .clear
        contentView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16.ratio())
            make.top.bottom.equalToSuperview()
        }
        bgImageView.addSubview(idCardImageView)
        idCardImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32.ratio())
            make.leading.equalToSuperview().inset(68.ratio())
            make.width.equalTo(112.ratio())
            make.height.equalTo(68.ratio())
        }
        bgImageView.addSubview(faceImageView)
        faceImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32.ratio())
            make.leading.equalTo(idCardImageView.snp.trailing).offset(20.ratio())
            make.width.equalTo(80.ratio())
            make.height.equalTo(68.ratio())
        }
    }
    
    func applyModel(){
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 9.ratio()
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(31.ratio())
            make.top.equalTo(idCardImageView.snp.bottom).offset(30.ratio())
            make.bottom.equalToSuperview().inset(23.ratio())
        }
        let subViews = model.items.map { model in
            let view = IdCardResultItemView.init(frame: .zero, model: model)
            view.snp.makeConstraints { make in
                make.width.equalTo(282.ratio())
                make.height.equalTo(60.ratio())
            }
            return view
        }
        stackView.addSubViews(views: subViews)
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
        self.model = model
    }
}

extension IDCardResultCell{
    struct Model {
        var items: [IdCardResultItemView.Model] = []
    }
}

class IdCardResultItemView: UIView {
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
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_black
        label.font = SLFont(size: 14, weight: .black)
        label.textAlignment = .center
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_6C6C6C
        label.font = SLFont(size: 13, weight: .black)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.layer.cornerRadius = 16.ratio()
        label.layer.masksToBounds = true
        return label
    }()
}

extension IdCardResultItemView{
    func setupUI(){
        backgroundColor = .clear
        addSubview(titleLabel)
        addSubview(contentLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30.ratio())
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6.ratio())
            make.leading.trailing.equalToSuperview().inset(30.ratio())
            make.height.equalTo(32.ratio())
            make.bottom.equalToSuperview()
        }
    }
    
    func applyModel(){
        titleLabel.text = model.title
        contentLabel.text = model.content
    }
}

extension IdCardResultItemView{
    struct Model {
        var title: String = ""
        var content: String = ""
    }
}

