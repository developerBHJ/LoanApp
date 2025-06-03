//
//  ProductAlertViewController.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/24.
//

import UIKit
class ProductAlertViewController: UIViewController {
    
    convenience init(model: Model = .init()) {
        self.init()
        self.model = model
        presentFullScreenAndDisablePullToDismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyModel()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    lazy var bgImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_product_alertBg")
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var titleImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = kColor_FFF20E
        view.font = SLFont(size: 19, weight: .black)
        view.textAlignment = .center
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(named: "icon_alert_close"), for: .normal)
        view.addTarget(self, action: #selector(closeEvent), for: .touchUpInside)
        return view
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(nextEvent), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "icon_product_alert_button"), for: .normal)
        return button
    }()
    
    private var contentView: UIView = UIView()
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
}

extension ProductAlertViewController{
    func setupUI(){
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = kColor_333333?.withAlphaComponent(0.5)
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(35.ratio())
            make.height.greaterThanOrEqualTo(312.ratio())
        }
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.bottom.equalTo(bgImageView.snp.top).offset(-25.ratio())
            make.trailing.equalToSuperview().inset(22.ratio())
            make.width.height.equalTo(25.ratio())
        }
        bgImageView.addSubview(titleImageView)
        bgImageView.addSubview(titleLabel)
        titleImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(21.ratio())
            make.width.lessThanOrEqualTo(175.ratio())
            make.height.equalTo(33.ratio())
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(21.ratio())
            make.height.equalTo(33.ratio())
        }
        bgImageView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(getNotchHeight())
            make.centerX.equalToSuperview()
            make.height.equalTo(50.ratio())
            make.width.equalTo(170.ratio())
        }
    }
    
    func applyModel(){
        bgImageView.image = UIImage(named: model.bgImage)
        if model.titleImage.isEmpty{
            titleLabel.isHidden = false
            titleImageView.isHidden = true
            titleLabel.text = model.title
        }else{
            titleLabel.isHidden = true
            titleImageView.isHidden = false
            titleImageView.image = UIImage(named: model.titleImage)
        }
        contentView.removeFromSuperview()
        contentView = model.contentView
        bgImageView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.bottom).offset(40.ratio())
            make.leading.trailing.equalToSuperview().inset(25.ratio())
            make.bottom.equalTo(confirmButton.snp.top).offset(-23.ratio())
        }
        if model.isAddressView{
            contentView.snp.makeConstraints { make in
                make.top.equalTo(titleImageView.snp.bottom).offset(40.ratio())
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(confirmButton.snp.top).offset(-23.ratio())
            }
        }else{
            contentView.snp.makeConstraints { make in
                make.top.equalTo(titleImageView.snp.bottom).offset(40.ratio())
                make.leading.trailing.equalToSuperview().inset(25.ratio())
                make.bottom.equalTo(confirmButton.snp.top).offset(-23.ratio())
            }
        }
        bgImageView.snp.updateConstraints { make in
            make.height.greaterThanOrEqualTo(model.contentHeight)
        }
        contentView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        confirmButton.setBackgroundImage(UIImage(named: model.buttonImage), for: .normal)
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    @objc func closeEvent(){
        popNavigation()
        model.closeCompletion?()
    }
    
    @objc func nextEvent(){
        popNavigation()
        model.confirmCompletion?()
    }
    
    @objc func keyboardWillHide(){
        bgImageView.snp.updateConstraints { make in
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func keyboardWillShow(notification: Notification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            bgImageView.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(-keyboardHeight)
            }
        }
    }
}

extension ProductAlertViewController{
    struct Model {
        var title: String = ""
        var titleImage: String = ""
        var contentView: UIView = UIView()
        var bgImage: String = "icon_product_alertBg"
        var buttonTitle: String = LocalizationConstants.Product.alertBottomButton
        var buttonImage: String = "icon_product_alert_button"
        var contentHeight: CGFloat = 312.ratio()
        var isAddressView: Bool = false
        var closeCompletion: (()-> Void)? = nil
        var confirmCompletion: (()-> Void)? = nil
    }
}
