//
//  OrderSegementView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/21.
//

import UIKit
class OrderSegementView: UIView {
    
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
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .leading
        view.spacing = 20.ratio()
        return view
    }()
    
    private var items: [UIButton] = []
    private var selectedButton: UIButton?
}

extension OrderSegementView{
    func setupUI(){
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func applyModel(){
        let buttons = model.items.enumerated().map { (index,type) in
            let button = UIButton(type: .custom)
            button.tag = 1000 + index
            button.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
            button.alpha = (index == model.currentIndex) ? 1.0 : 0.5
            if (index == model.currentIndex) {
                selectedButton = button
            }
            if let image = UIImage(named: type.image){
                button.snp.makeConstraints { make in
                    make.width.equalTo(image.size.width / 2)
                    make.height.equalTo(image.size.height / 2)
                }
                button.setImage(image, for: .normal)
            }
            return button
        }
        items = buttons
        stackView.removeAllSubViews()
        stackView.addSubViews(views: buttons)
    }
    
    @objc func buttonEvent(sender: UIButton){
        guard selectedButton != sender else {return}
        selectedButton = sender
        let tag = sender.tag - 1000
        items.enumerated().forEach({ (index,button) in
            button.alpha = (index == tag) ? 1.0 : 0.5
        })
        let type = SegementType.init(rawValue: tag) ?? .all
        model.selectedCompletion?(type)
    }
}

extension OrderSegementView{
    enum SegementType: Int,CaseIterable {
        case all = 0
        case applying
        case repayment
        case finish
    }
    
    struct Model {
        var items: [SegementType] = SegementType.allCases
        var currentIndex: Int = 0
        var selectedCompletion: ((SegementType) -> Void)? = nil
    }
}

extension OrderSegementView.SegementType{
    var image: String{
        switch self {
        case .all:
            "icon_order_all"
        case .applying:
            "icon_order_applying"
        case .repayment:
            "icon_order_repayment"
        case .finish:
            "icon_order_finish"
        }
    }
    
    var typeCode:Int{
        switch self {
        case .all:
            4
        case .applying:
            7
        case .repayment:
            6
        case .finish:
            5
        }
    }
}
