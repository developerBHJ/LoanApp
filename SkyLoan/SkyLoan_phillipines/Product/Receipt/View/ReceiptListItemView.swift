//
//  ReceiptListItemView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/29.
//

import UIKit
class ReceiptListItemView: UIView {
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
    
    lazy var nameView: ProductInputView = {
        let view = ProductInputView(frame: .zero, model: .init())
        return view
    }()
}

extension ReceiptListItemView{
    func setupUI(){
        backgroundColor = .clear
        addSubview(titleLabel)
        addSubview(nameView)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(25.ratio())
        }
        nameView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5.ratio())
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(33.ratio())
            make.bottom.equalToSuperview()
        }
    }
    
    func applyModel(){
        titleLabel.text = model.title
        nameView.model = model.nameViewModel
    }
}

extension ReceiptListItemView{
    struct Model {
        var title: String = ""
        var nameViewModel: ProductInputView.Model = .init()
    }
}
