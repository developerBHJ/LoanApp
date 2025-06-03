//
//  ProductInputView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/28.
//

import UIKit
class ProductInputView: UIView {
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
    
    lazy var bgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_input_bg")
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var inputTextField: UITextField = {
        let view = UITextField()
        view.textColor = kColor_black
        view.font = SLFont(size: 13, weight: .black)
        view.delegate = self
        view.addTarget(self, action: #selector(valueChanged(textField:)), for: .editingChanged)
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
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
}

extension ProductInputView{
    func setupUI(){
        backgroundColor = .clear
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        addSubview(inputTextField)
        inputTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(12.ratio())
            make.trailing.equalToSuperview().inset(44.ratio())
        }
        addSubview(arrowView)
        arrowView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10.ratio())
            make.centerY.equalToSuperview()
            make.width.height.equalTo(22.ratio())
        }
        addSubview(tapButton)
        tapButton.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func applyModel(){
        inputTextField.text = model.content
        inputTextField.placeholder = model.placeHolder
        arrowView.isHidden = !model.isPicker
        inputTextField.isUserInteractionEnabled = !model.isPicker
        tapButton.isHidden = !model.isPicker
        inputTextField.textColor = model.textColor
        inputTextField.font = model.textFont
        inputTextField.keyboardType = (model.keyBordType == 1) ? .numberPad : .default
    }
    
    @objc func tapEvent(){
        inputTextField.resignFirstResponder()
        self.textFieldDidEndEditing(inputTextField)
        model.pickCompletion?(model.key,model.options)
    }
    
    @objc func valueChanged(textField: UITextField){
        model.valueChanged?(model.key,textField.text ?? "")
    }
}

extension ProductInputView: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        model.valueChanged?(model.key,textField.text ?? "")
    }
}

extension ProductInputView{
    struct Model {
        var key: String = ""
        var content: String = ""
        var placeHolder: String = ""
        var isPicker: Bool = false
        var keyBordType: Int = 0
        var options: [ProductFormItem] = []
        let textColor: UIColor = kColor_black
        let textFont: UIFont = SLFont(size: 13, weight: .black)
        var valueChanged: ((String,String)->Void)? = nil
        var pickCompletion: ((String,[ProductFormItem])-> Void)? = nil
    }
}
