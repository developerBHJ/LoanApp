//
//  PersonalBasicInfoItemView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/27.
//

import UIKit
class PersonalBasicInfoItemView: UIView {
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
        label.font = SLFont(size: 12, weight: .black)
        return label
    }()
    
    lazy var inputBgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_input_bg")
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var contentTextField: UITextField = {
        let view = UITextField()
        view.textColor = kColor_black
        view.font = SLFont(size: 13, weight: .black)
        view.delegate = self
        return view
    }()
    
    lazy var arrowView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_arrow_right")
        return view
    }()
    
    lazy var tapButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(tapEvent), for: .touchUpInside)
        return view
    }()
    
    lazy var secondTextField: UITextField = {
        let view = UITextField()
        view.textColor = kColor_black
        view.font = SLFont(size: 13, weight: .black)
        view.delegate = self
        return view
    }()
    
    lazy var secondInputBgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_input_bg")
        view.isUserInteractionEnabled = true
        return view
    }()
}

extension PersonalBasicInfoItemView{
    func setupUI(){
        backgroundColor = .clear
        addSubview(titleLabel)
        addSubview(inputBgView)
        addSubview(contentTextField)
        inputBgView.addSubview(tapButton)
        addSubview(arrowView)
        addSubview(secondInputBgView)
        addSubview(secondTextField)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(25.ratio())
        }
        inputBgView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5.ratio())
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(33.ratio())
        }
        contentTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5.ratio())
            make.leading.equalToSuperview().inset(12.ratio())
            make.trailing.equalToSuperview().inset(44.ratio())
            make.height.equalTo(33.ratio())
        }
        arrowView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10.ratio())
            make.centerY.equalTo(contentTextField)
            make.width.height.equalTo(22.ratio())
        }
        tapButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        secondInputBgView.snp.makeConstraints { make in
            make.top.equalTo(contentTextField.snp.bottom).offset(12.ratio())
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(33.ratio())
        }
        secondTextField.snp.makeConstraints { make in
            make.top.equalTo(contentTextField.snp.bottom).offset(12.ratio())
            make.leading.trailing.equalToSuperview().inset(12.ratio())
            make.height.equalTo(33.ratio())
        }
    }
    
    func applyModel(){
        titleLabel.text = model.title
        contentTextField.text = model.content
        contentTextField.keyboardType = (model.keyBordType == 1) ? .numberPad : .default
        contentTextField.placeholder = model.placeHolder
        arrowView.isHidden = !model.isPicker
        tapButton.isHidden = !model.isPicker
        contentTextField.isUserInteractionEnabled = !model.isPicker
        secondTextField.isHidden = !model.needSecond
        secondInputBgView.isHidden = !model.needSecond
        let topSpace = model.needSecond ? 12.ratio() : 0
        let secondHeight = model.needSecond ? 33.ratio() : 0
        if model.needSecond{
            secondTextField.placeholder = model.secondPlaceHolder
            secondTextField.text = model.secondContent
        }
        secondInputBgView.snp.updateConstraints { make in
            make.top.equalTo(contentTextField.snp.bottom).offset(topSpace)
            make.height.equalTo(secondHeight)
        }
        secondTextField.snp.updateConstraints { make in
            make.top.equalTo(contentTextField.snp.bottom).offset(topSpace)
            make.height.equalTo(secondHeight)
        }
    }
    
    @objc func tapEvent(){
        self.textFieldDidEndEditing(contentTextField)
        self.textFieldDidEndEditing(secondTextField)
        contentTextField.resignFirstResponder()
        secondTextField.resignFirstResponder()
        model.pickCompletion?(model.options)
    }
}
extension PersonalBasicInfoItemView{
    struct Model {
        var title: String = ""
        var placeHolder: String = ""
        var content: String = ""
        var keyBordType: Int = 0
        var isPicker: Bool = false
        var key: String = ""
        var options: [ProductFormItem] = []
        var needSecond: Bool = false
        var secondKey: String = ""
        var secondPlaceHolder: String = ""
        var secondContent: String = ""
        var valueChanged: ((String,String)-> Void)? = nil
        var secondValueChanged: ((String,String)-> Void)? = nil
        var pickCompletion: (([ProductFormItem])->Void)? = nil
    }
}

extension PersonalBasicInfoItemView: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == contentTextField {
            model.valueChanged?(model.key,textField.text ?? "")
        }else{
            model.secondValueChanged?(model.secondKey,textField.text ?? "")
        }
    }
}
