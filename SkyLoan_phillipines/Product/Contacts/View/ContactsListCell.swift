//
//  ContactsListCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/28.
//

import UIKit
class ContactsListCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
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
    
    lazy var contentBgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25.ratio()
        view.layer.masksToBounds = true
        return view
    }()
    
    var stackView: UIStackView?
}

extension ContactsListCell{
    func setupUI(){
        backgroundColor = .clear
        contentView.addSubview(contentBgView)
        contentBgView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16.ratio())
        }
    }
    
    func applyModel(){
        stackView?.removeFromSuperview()
        guard let stackView = creatStackView() else {return}
        self.stackView = stackView
        contentBgView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30.ratio())
            make.leading.trailing.equalToSuperview().inset(20.ratio())
            make.bottom.equalToSuperview().inset(30.ratio())
        }
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    private func creatStackView()-> UIStackView? {
        guard !model.items.isEmpty else {return nil}
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20.ratio()
        stackView.alignment = .fill
        stackView.distribution = .fill
        let itemViews = model.items.map { model in
            let view = ContactsListItemView.init(frame: .zero,model: model)
            return view
        }
        stackView.addSubViews(views: itemViews)
        return stackView
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
        self.model = model
    }
}

extension ContactsListCell{
    struct Model {
        var items: [ContactsListItemView.Model] = []
    }
}


