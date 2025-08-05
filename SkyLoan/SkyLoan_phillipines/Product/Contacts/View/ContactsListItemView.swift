//
//  ContactsListItemView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/28.
//
import UIKit
class ContactsListItemView: UIView {
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
    
    lazy var relationshipView: ProductInputView = {
        let view = ProductInputView(frame: .zero, model: .init())
        return view
    }()
    
    lazy var nameView: ProductInputView = {
        let view = ProductInputView(frame: .zero, model: .init())
        return view
    }()
}

extension ContactsListItemView{
    func setupUI(){
        backgroundColor = .clear
        addSubview(titleLabel)
        addSubview(relationshipView)
        addSubview(nameView)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(25.ratio())
        }
        relationshipView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5.ratio())
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(33.ratio())
        }
        nameView.snp.makeConstraints { make in
            make.top.equalTo(relationshipView.snp.bottom).offset(12.ratio())
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(33.ratio())
            make.bottom.equalToSuperview()
        }
    }
    
    func applyModel(){
        titleLabel.text = model.title
        relationshipView.model = model.relationshipModel
        nameView.model = model.nameViewModel
    }
}
extension ContactsListItemView{
    struct Model {
        var title: String = ""
        var relationshipModel: ProductInputView.Model = .init()
        var nameViewModel: ProductInputView.Model = .init()
    }
}
