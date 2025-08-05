//
//  InputView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/13.
//

import UIKit
class InputView: UIView{
    
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.textColor = kColor_black
        view.font = SLFont(size: 15,weight: .black)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var inputBgView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var inputTexField: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.addTarget(self, action: #selector(textValueChanged), for: .editingChanged)
        view.textColor = kColor_161616
        view.font = SLFont(size: 13, weight: .black)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftView: UILabel = {
        let view = UILabel()
        view.textColor = kColor_black
        view.font = SLFont(size: 15,weight: .black)
        view.layer.cornerRadius = 15.ratio()
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.textAlignment = .center
        return view
    }()
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
    
    private var leftConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        addSubview(titleView)
        addSubview(inputBgView)
        addSubview(inputTexField)
        addSubview(leftView)
        leftConstraint = inputTexField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4.ratio() + model.leftViewSize.width + 14.ratio())
        if let leftConstraint = leftConstraint{
            NSLayoutConstraint.activate([
                titleView.topAnchor.constraint(equalTo: topAnchor),
                titleView.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleView.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                inputBgView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20.ratio()),
                inputBgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                inputBgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                inputBgView.heightAnchor.constraint(equalToConstant: model.inputViewHeight),
                inputBgView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                leftView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4.ratio()),
                leftView.centerYAnchor.constraint(equalTo: inputBgView.centerYAnchor),
                leftView.widthAnchor.constraint(equalToConstant: model.leftViewSize.width),
                leftView.heightAnchor.constraint(equalToConstant: model.leftViewSize.height),
                
                inputTexField.topAnchor.constraint(equalTo: inputBgView.topAnchor),
                inputTexField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                inputTexField.bottomAnchor.constraint(equalTo: inputBgView.bottomAnchor),
                leftConstraint
            ])
        }
    }
    
    func updateUI(){
        leftView.isHidden = !model.needLeftView
        leftConstraint?.constant = model.needLeftView ? (4.ratio() + model.leftViewSize.width + 14.ratio()) : 20.ratio()
        inputTexField.keyboardType = model.keyBorad
    }
    
    func applyModel(){
        updateUI()
        inputBgView.image = UIImage(named: model.inputBg)
        titleView.text = model.title
        let attPlaceholder = NSMutableAttributedString(string: model.placeHolder)
        attPlaceholder.addAttributes([NSAttributedString.Key.font:SLFont(size: 13,weight: .black),NSAttributedString.Key.foregroundColor: kColor_161616?.withAlphaComponent(0.47) ?? .black], range: .init(location: 0, length: attPlaceholder.length))
        inputTexField.attributedPlaceholder = attPlaceholder
        inputTexField.text = model.text
        leftView.text = model.leftTitle
    }
    
    @objc func textValueChanged(){
        // do something
    }
}

extension InputView{
    struct Model {
        var title: String = ""
        var text: String = ""
        var placeHolder: String = ""
        var inputBg: String = "icon_login_input_bg"
        var inputViewHeight: CGFloat = 50.ratio()
        var keyBorad: UIKeyboardType = .numberPad
        var maxLength: Int = 999_999
        var needLeftView: Bool = false
        var leftTitle: String = kCountryCode
        var leftViewSize: CGSize = .init(width: 57.ratio(), height: 43.ratio())
        var valueChanged: ((String) -> Void)? = nil
    }
}

extension InputView: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        model.valueChanged?(textField.text ?? "")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {return false}
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        return updateText.count <= model.maxLength
    }
}
