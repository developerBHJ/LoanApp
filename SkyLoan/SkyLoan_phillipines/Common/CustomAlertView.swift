//
//  CustomAlertView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/20.
//

import UIKit
class CustomAlertView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyModel()
    }
    
    convenience init(model: Model) {
        self.init()
        self.model = model
        presentFullScreenAndDisablePullToDismiss()
    }
    
    lazy var contentBgView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var contentView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_alert_bg")?.resizableImage(withCapInsets: .init(top: 20, left: 0, bottom: 20, right: 0))
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "icon_alert_close"), for: .normal)
        view.addTarget(self, action: #selector(closeEvent), for: .touchUpInside)
        return view
    }()
    
    lazy var titleView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = SLFont(size: 14,weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var checBox: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(checkBoxEvent(sender:)), for: .touchUpInside)
        button.setImage(nil, for: .normal)
        button.setImage(UIImage(named: "icon_alert_checkBox_sel"), for: .selected)
        button.setImage(UIImage(named: "icon_alert_checkBox_sel"), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "icon_alert_chekBox"), for: .normal)
        button.hitTestEdgeInsets = .init(top: -20, left: -20, bottom: -20, right: -20)
        return button
    }()
    
    lazy var privacyLabel: TapLabel = {
        let view = TapLabel(frame: .zero, model: .init())
        view.textColor = kColor_black
        view.font = SLFont(size: 12)
        return view
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(confirmEvent(sender:)), for: .touchUpInside)
        button.setTitle("", for: .normal)
        button.setTitleColor(kColor_black, for: .normal)
        button.titleLabel?.font = SLFont(size: 15, weight: .black)
        button.setBackgroundImage(UIImage(named: "icon_alert_button"), for: .normal)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(cancelEvent(sender:)), for: .touchUpInside)
        button.setTitle("", for: .normal)
        button.setTitleColor(kColor_black, for: .normal)
        button.titleLabel?.font = SLFont(size: 15, weight: .black)
        button.setBackgroundImage(UIImage(named: "icon_alert_button"), for: .normal)
        return button
    }()
    
    lazy var privacyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
    
    private var selectedButton: UIButton?
}

extension CustomAlertView{
    
    func setupUI(){
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = kColor_333333?.withAlphaComponent(0.5)
        view.addSubview(contentBgView)
        contentBgView.addSubview(contentView)
        contentBgView.addSubview(closeButton)
        contentView.addSubview(titleView)
        contentView.addSubview(contentLabel)
        contentBgView.addSubview(confirmButton)
        contentBgView.addSubview(cancelButton)
        contentBgView.addSubview(privacyView)
        privacyView.addSubview(checBox)
        privacyView.addSubview(privacyLabel)
        
        contentBgView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(35.ratio())
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.height.equalTo(25.ratio())
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(23.ratio())
            make.leading.trailing.equalToSuperview()
        }
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21.ratio())
            make.centerX.equalToSuperview()
            make.height.equalTo(27.5.ratio())
            make.width.lessThanOrEqualTo(188.ratio())
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(32.ratio())
            make.leading.trailing.equalToSuperview().inset(52.ratio())
            make.bottom.equalToSuperview().inset(28.ratio())
        }
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(27.ratio())
            make.leading.equalTo(contentView.snp.centerX).offset(13.ratio())
            make.width.equalTo(105.ratio())
            make.height.equalTo(46.5.ratio())
            make.bottom.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(27.ratio())
            make.trailing.equalTo(contentView.snp.centerX).offset(-13.ratio())
            make.width.equalTo(105.ratio())
            make.height.equalTo(46.5.ratio())
        }
        
        privacyView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).offset(23.ratio())
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(33.ratio())
        }
        
        checBox.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.height.equalTo(16.ratio())
        }
        privacyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(checBox.snp.trailing).offset(6.ratio())
            make.trailing.equalToSuperview().inset(10.ratio())
        }
        contentLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func applyModel(){
        titleView.image = UIImage(named: model.type.titleImage)
        contentLabel.text = model.type.content
        confirmButton.setTitle(model.type.confirmButtonTitle, for: .normal)
        cancelButton.setTitle(model.type.cancelButtonTitle, for: .normal)
        privacyLabel.text = model.privacy
        contentLabel.setLineHeight(26.ratio())
        updateUI()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    private func updateUI(){
        if model.type == .stay{
            selectedButton = cancelButton
            updateButton(sender: confirmButton)
            confirmButton.snp.remakeConstraints { make in
                make.top.equalTo(contentView.snp.bottom).offset(27.ratio())
                make.leading.equalTo(contentView.snp.centerX).offset(13.ratio())
                make.width.equalTo(105.ratio())
                make.height.equalTo(46.5.ratio())
                make.bottom.equalToSuperview()
            }
            
            cancelButton.snp.remakeConstraints { make in
                make.top.equalTo(contentView.snp.bottom).offset(27.ratio())
                make.trailing.equalTo(contentView.snp.centerX).offset(-13.ratio())
                make.width.equalTo(105.ratio())
                make.height.equalTo(46.5.ratio())
            }
        }else if model.type == .exit{
            selectedButton = confirmButton
            updateButton(sender: cancelButton)
            confirmButton.snp.remakeConstraints { make in
                make.top.equalTo(contentView.snp.bottom).offset(27.ratio())
                make.trailing.equalTo(contentView.snp.centerX).offset(-13.ratio())
                make.width.equalTo(120.ratio())
                make.height.equalTo(46.5.ratio())
                make.bottom.equalToSuperview()
            }
            cancelButton.snp.remakeConstraints { make in
                make.top.equalTo(contentView.snp.bottom).offset(27.ratio())
                make.leading.equalTo(contentView.snp.centerX).offset(13.ratio())
                make.width.equalTo(150.ratio())
                make.height.equalTo(46.5.ratio())
            }
        } else{
            selectedButton = confirmButton
            updateButton(sender: cancelButton)
            confirmButton.setBackgroundImage(nil, for: .normal)
            cancelButton.snp.remakeConstraints { make in
                make.top.equalTo(privacyView.snp.bottom).offset(27.ratio())
                make.centerX.equalToSuperview()
                make.width.equalTo(150.ratio())
                make.height.equalTo(46.5.ratio())
            }
            
            confirmButton.snp.remakeConstraints { make in
                make.top.equalTo(cancelButton.snp.bottom)
                make.centerX.equalToSuperview()
                make.width.equalTo(260.ratio())
                make.height.equalTo(46.5.ratio())
                make.bottom.equalToSuperview()
            }
        }
        privacyView.isHidden = (model.type != .cancellation)
    }
    
    @objc func closeEvent(){
        self.dismiss(animated: false)
        model.closeCompletion?()
    }
    
    @objc func checkBoxEvent(sender: UIButton){
        sender.isSelected = !sender.isSelected
        model.checkBoxCompletion?(sender.isSelected)
    }
    
    @objc func confirmEvent(sender: UIButton){
        updateButton(sender: sender)
        model.confirmCompletion?()
    }
    
    @objc func cancelEvent(sender: UIButton){
        updateButton(sender: sender)
        model.cancelCompletion?()
    }
    
    private func updateButton(sender: UIButton){
        guard selectedButton != sender else {return }
        if model.type == .cancellation {
            let image = UIImage(named: "icon_product_item_bg")
            sender.setBackgroundImage(image, for: .normal)
            sender.setTitleColor(kColor_black, for: .normal)
            sender.titleLabel?.font = SLFont(size: 15, weight: .black)
            selectedButton?.setBackgroundImage(nil, for: .normal)
            selectedButton?.setTitleColor(kColor_C3C3C3, for: .normal)
            selectedButton?.titleLabel?.font = SLFont(size: 14, weight: .black)
        }else{
            sender.setBackgroundImage(UIImage(named: "icon_alert_button"), for: .normal)
            selectedButton?.setBackgroundImage(UIImage(named: "icon_alert_button"), for: .normal)
            selectedButton?.alpha = 0.5
            sender.alpha = 1.0
        }
        selectedButton = sender
    }
}

extension CustomAlertView{
    enum AlertType {
        case stay
        case exit
        case cancellation
    }
    
    struct Model {
        var type: AlertType = .stay
        var privacy: String = LocalizationConstants.Alert.cancellation_privacy
        var closeCompletion: (()-> Void)? = nil
        var confirmCompletion: (()-> Void)? = nil
        var cancelCompletion: (()-> Void)? = nil
        var checkBoxCompletion: ((Bool)-> Void)? = nil
    }
}

extension CustomAlertView.AlertType{
    var titleImage: String{
        switch self {
        case .stay:
            return "icon_alert_stay"
        case .exit:
            return "icon_alert_exit"
        case .cancellation:
            return "icon_alert_cancellation"
        }
    }
    
    var confirmButtonTitle: String{
        switch self {
        case .stay:
            return LocalizationConstants.Alert.stay_confirm
        case .exit:
            return LocalizationConstants.Alert.exit_confirm
        case .cancellation:
            return LocalizationConstants.Alert.cancellation_confirm
        }
    }
    
    var cancelButtonTitle: String{
        switch self {
        case .stay:
            return LocalizationConstants.Alert.stay_cancel
        case .exit:
            return LocalizationConstants.Alert.exit_cancel
        case .cancellation:
            return LocalizationConstants.Alert.cancellation_cancel
        }
    }
    
    var content: String{
        switch self {
        case .stay:
            return LocalizationConstants.Alert.stay_content
        case .exit:
            return LocalizationConstants.Alert.exit_content
        case .cancellation:
            return LocalizationConstants.Alert.cancellation_content
        }
    }
}
