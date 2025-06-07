//
//  PrivacyView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/13.
//

import UIKit
class PrivacyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var checBox: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(checkBoxEvent(sender:)), for: .touchUpInside)
        button.hitTestEdgeInsets = .init(top: -10, left: -10, bottom: -10, right: -10)
        return button
    }()
    
    lazy var privacyLabel: TapLabel = {
        let view = TapLabel(frame: .zero, model: .init())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
    
    private func setupUI(){
        addSubview(checBox)
        addSubView(view: checBox, leadingConstant: 0,centerYConstant: 0,width: 9.ratio(),height: 9.ratio())
        addSubview(privacyLabel)
        NSLayoutConstraint.activate([
            privacyLabel.leadingAnchor.constraint(equalTo: checBox.trailingAnchor, constant: 6.ratio()),
            privacyLabel.topAnchor.constraint(equalTo: topAnchor),
            privacyLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            privacyLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    private func applyModel(){
        checBox.setImage(UIImage(named: model.normalImage), for: .normal)
        checBox.setImage(UIImage(named: model.selectedImage), for: .highlighted)
        checBox.setImage(UIImage(named: model.selectedImage), for: .selected)
        checBox.isSelected = model.isSelected
        privacyLabel.model = .init(regluarText: model.normalStr,linkText: model.linkStr,linkUrl: model.linkUrl,tapCompletion: {[weak self] value in
            self?.model.tapLinkCompletion?(value)
        })
    }
    
    @objc private func checkBoxEvent(sender: UIButton){
        sender.isSelected.toggle()
        model.isSelected.toggle()
        model.checkBoxCompletion?(model.isSelected)
    }
}

extension PrivacyView{
    struct Model {
        let normalImage: String = "icon_checkBox_normal"
        let selectedImage: String = "icon_checkBox_sel"
        var normalStr: String = ""
        var linkStr: String = ""
        var linkUrl: String = ""
        var isSelected: Bool = true
        var checkBoxCompletion: ((Bool) -> Void)? = nil
        var tapLinkCompletion: ((String) -> Void)? = nil
    }
}
