//
//  AuthenInfoConfirmCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/26.
//

import UIKit

class AuthenInfoConfirmCell: UITableViewCell {
    
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
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = SLFont(size: 14, weight: .semibold)
        view.textAlignment = .center
        return view
    }()
    
    lazy var contentLabel: UITextField = {
        let view = UITextField()
        view.textColor = kColor_black
        view.font = SLFont(size: 13, weight: .semibold)
        view.textAlignment = .center
        view.delegate = self
        return view
    }()
    
    lazy var arrowView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_arrow_right")
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = kColor_black
        return view
    }()
    
    lazy var tapButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(tapEvent), for: .touchUpInside)
        return view
    }()
}

extension AuthenInfoConfirmCell{
    func setupUI(){
        backgroundColor = .clear
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(tapButton)
        contentView.addSubview(arrowView)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.ratio())
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20.ratio())
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12.ratio())
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(6.ratio())
            make.height.equalTo(20.ratio())
        }
        arrowView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(contentLabel)
            make.width.height.equalTo(22.ratio())
        }
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        tapButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func applyModel(){
        titleLabel.text = model.title
        contentLabel.text = model.content
        arrowView.isHidden = !model.isPicker
        tapButton.isHidden = !model.isPicker
        contentLabel.isUserInteractionEnabled = !model.isPicker
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
        self.model = model
    }
    
    @objc func tapEvent(){
        self.textFieldDidEndEditing(contentLabel)
        contentLabel.resignFirstResponder()
        model.pickCompletion?()
    }
}

extension AuthenInfoConfirmCell{
    struct Model {
        var title: String = ""
        var content: String = ""
        var isPicker: Bool = false
        var valueChanged: ((String)-> Void)? = nil
        var pickCompletion: (()->Void)? = nil
    }
}

extension AuthenInfoConfirmCell: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        model.valueChanged?(textField.text ?? "")
    }
}


