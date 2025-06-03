//
//  ReceiptListCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/29.
//

import UIKit

class ReceiptListCell: UITableViewCell {
    
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
    
    lazy var walletButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
        button.tag = 1000
        button.setTitleColor(kColor_FB4F41?.withAlphaComponent(0.5), for: .normal)
        button.setTitleColor(kColor_FB4F41, for: .highlighted)
        button.setTitleColor(kColor_FB4F41, for: .selected)
        button.titleLabel?.font = SLFont(size: 19, weight: .black)
        return button
    }()
    
    lazy var bankButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
        button.tag = 1001
        button.setTitleColor(kColor_FB4F41?.withAlphaComponent(0.5), for: .normal)
        button.setTitleColor(kColor_FB4F41, for: .highlighted)
        button.setTitleColor(kColor_FB4F41, for: .selected)
        button.titleLabel?.font = SLFont(size: 19, weight: .black)
        return button
    }()
    
    var headerView: UIStackView?
    var stackView: UIStackView?
}

extension ReceiptListCell{
    func setupUI(){
        backgroundColor = .clear
        contentView.addSubview(contentBgView)
        contentBgView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16.ratio())
        }
    }
    
    func applyModel(){
        headerView?.removeFromSuperview()
        if let headerView = configHeaderView(){
            self.headerView = headerView
            contentBgView.addSubview(headerView)
            headerView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(30.ratio())
                make.leading.equalToSuperview().inset(20.ratio())
                make.trailing.lessThanOrEqualToSuperview().inset(20.ratio())
                make.height.equalTo(30.ratio())
            }
            stackView?.removeFromSuperview()
            if let stackView = creatStackView() {
                self.stackView = stackView
                contentBgView.addSubview(stackView)
                stackView.snp.makeConstraints { make in
                    make.top.equalTo(headerView.snp.bottom).offset(20.ratio())
                    make.leading.trailing.equalToSuperview().inset(20.ratio())
                    make.bottom.equalToSuperview().inset(30.ratio())
                }
                stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
            }
        }else{
            stackView?.removeFromSuperview()
            if let stackView = creatStackView() {
                self.stackView = stackView
                contentBgView.addSubview(stackView)
                stackView.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(30.ratio())
                    make.leading.trailing.equalToSuperview().inset(20.ratio())
                    make.bottom.equalToSuperview().inset(30.ratio())
                }
                stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
            }
        }
    }
    
    private func creatStackView()-> UIStackView? {
        guard !model.items.isEmpty else {return nil}
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20.ratio()
        stackView.alignment = .fill
        stackView.distribution = .fill
        let itemViews = model.items.map { model in
            let view = ReceiptListItemView.init(frame: .zero,model: model)
            return view
        }
        stackView.addSubViews(views: itemViews)
        return stackView
    }
    
    private func configHeaderView() -> UIStackView?{
        guard !model.items.isEmpty else {return nil}
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 30.ratio()
        let items: [UIButton] = model.segements.enumerated().map { index,title in
            let button = UIButton(type: .custom)
            button.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
            button.tag = 1000 + index
            button.setTitleColor(kColor_FB4F41?.withAlphaComponent(0.5), for: .normal)
            button.setTitleColor(kColor_FB4F41, for: .highlighted)
            button.setTitleColor(kColor_FB4F41, for: .selected)
            button.titleLabel?.font = SLFont(size: 19, weight: .black)
            button.setTitle(title, for: .normal)
            let titleWidth = title.getWidth(font: SLFont(size: 19, weight: .black))
            button.snp.makeConstraints { make in
                make.width.greaterThanOrEqualTo(titleWidth)
                make.height.equalTo(30.ratio())
            }
            button.isSelected = (model.currentIndex == index)
            return button
        }
        stackView.addSubViews(views: items)
        return stackView
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
        self.model = model
    }
    
    @objc func buttonEvent(sender: UIButton){
        let tag = sender.tag - 1000
        guard tag != model.currentIndex else {return}
        if model.segementType.count > tag {
            let type = model.segementType[tag]
            model.segementCompletion?(type)
        }
    }
}

extension ReceiptListCell{
    struct Model {
        var items: [ReceiptListItemView.Model] = []
        var segements: [String] = []
        var segementType: [Int] = []
        var currentIndex: Int = 0
        var segementCompletion: ((Int)-> Void)? = nil
    }
}

