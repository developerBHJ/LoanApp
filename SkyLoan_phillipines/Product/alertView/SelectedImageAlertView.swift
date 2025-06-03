//
//  SelectedImageAlertView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/24.
//

import UIKit

class SelectedImageAlertView: UIView {
    
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
    
    lazy var photoImageView: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_product_library"), for: .normal)
        button.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
        button.tag = 1000
        return button
    }()
    
    lazy var cameraImageView: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_product_library"), for: .normal)
        button.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
        button.tag = 1001
        return button
    }()
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
}

extension SelectedImageAlertView{
    
    func setupUI(){
        addSubview(photoImageView)
        addSubview(cameraImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalTo(self.snp.centerX).offset(-12.ratio())
            make.width.equalTo(112.ratio())
            make.height.equalTo(101.ratio())
            make.bottom.equalToSuperview()
        }
        cameraImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(self.snp.centerX).offset(12.ratio())
            make.width.equalTo(112.ratio())
            make.height.equalTo(101.ratio())
        }
    }
    
    func applyModel(){
        photoImageView.setImage(UIImage(named: model.leftImage), for: .normal)
        cameraImageView.setImage(UIImage(named: model.rightImage), for: .normal)
    }
    
    @objc func buttonEvent(sender: UIButton){
        model.selectedCompletion?(sender.tag - 1000)
    }
}

extension SelectedImageAlertView{
    struct Model {
        var leftImage: String = "icon_product_library"
        var rightImage: String = "icon_product_camera"
        var selectedCompletion:((Int)-> Void)? = nil
    }
}
