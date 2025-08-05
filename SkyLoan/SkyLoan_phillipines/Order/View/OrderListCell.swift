//
//  OrderListCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/21.
//

import UIKit

class OrderListCell: UITableViewCell {
    
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
    
    lazy var bgImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_order_itemBg")
        return view
    }()
    
    lazy var logoView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 11.ratio()
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var statusView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var statusLabel: UILabel = {
        let view = UILabel()
        view.textColor = kColor_black
        view.font = SLFont(size: 14,weight: .black)
        view.textAlignment = .center
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = kColor_black
        view.font = SLFont(size: 15,weight: .semibold)
        return view
    }()
    
    lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.textColor = kColor_black
        view.font = SLFont(size: 30,weight: .black)
        return view
    }()
    
    lazy var amountDescLabel: UILabel = {
        let view = UILabel()
        view.textColor = kColor_black.withAlphaComponent(0.7)
        view.font = SLFont(size: 11)
        return view
    }()
    
    lazy var timeView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_order_time")
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.textColor = kColor_black
        view.font = SLFont(size: 12,weight: .semibold)
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = kColor_black
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = SLFont(size: 12, weight: .black)
        button.layer.cornerRadius = 15.ratio()
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonEvent), for: .touchUpInside)
        button.setImage(UIImage(named: "icon_next_white"), for: .normal)
        return button
    }()
    
    lazy var noticeView: UIView = {
        let view = UIView()
        view.backgroundColor = kColor_D8D8D8
        view.layer.cornerRadius = 2.ratio()
        view.layer.masksToBounds = true
        view.alpha = 0.5
        return view
    }()
    
    lazy var noticeImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_order_warnning")
        return view
    }()
    
    lazy var noticeLabel: UILabel = {
        let view = UILabel()
        view.textColor = kColor_black
        view.font = SLFont(size: 9)
        return view
    }()
}

extension OrderListCell{
    func setupUI(){
        backgroundColor = .clear
        contentView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16.ratio())
            make.bottom.equalToSuperview().inset(12.ratio())
        }
        bgImageView.addSubview(statusView)
        statusView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(10.ratio())
            make.width.equalTo(100.ratio())
            make.height.equalTo(39.ratio())
        }
        
        statusView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22.ratio())
            make.leading.equalToSuperview().inset(48.ratio())
            make.trailing.equalTo(statusView.snp.leading).inset(10.ratio())
            make.height.equalTo(21.ratio())
        }
        bgImageView.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22.ratio())
            make.leading.equalToSuperview().inset(19.ratio())
            make.width.height.equalTo(22.ratio())
        }
        bgImageView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14.ratio())
            make.leading.equalToSuperview().inset(19.ratio())
            make.height.equalTo(36.ratio())
        }
        bgImageView.addSubview(amountDescLabel)
        amountDescLabel.snp.makeConstraints { make in
            make.bottom.equalTo(amountLabel.snp.bottom)
            make.leading.equalTo(amountLabel.snp.trailing).offset(10.ratio())
            make.trailing.lessThanOrEqualToSuperview().inset(10.ratio())
        }
        
        bgImageView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(20.ratio())
            make.leading.equalToSuperview().inset(36.ratio())
            make.height.equalTo(18.ratio())
        }
        bgImageView.addSubview(timeView)
        timeView.snp.makeConstraints { make in
            make.centerY.equalTo(timeLabel)
            make.leading.equalToSuperview().inset(19.ratio())
            make.width.height.equalTo(12.ratio())
        }
        bgImageView.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom).offset(7.ratio())
            make.trailing.equalToSuperview().inset(19.ratio())
            make.width.equalTo(111.ratio())
            make.height.equalTo(30.ratio())
        }
        bgImageView.addSubview(noticeView)
        noticeView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(15.ratio())
            make.leading.trailing.equalToSuperview().inset(20.ratio())
            make.width.equalTo(111.ratio())
            make.height.equalTo(30.ratio())
            make.bottom.equalToSuperview().inset(10.ratio())
        }
        noticeView.addSubview(noticeImageView)
        noticeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(9.ratio())
            make.width.height.equalTo(9.ratio())
        }
        noticeView.addSubview(noticeLabel)
        noticeLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(noticeImageView.snp.trailing).offset(6.ratio())
            make.trailing.equalToSuperview().inset(10.ratio())
        }
    }
    
    func applyModel(){
        logoView.kf.setImage(with: URL(string: model.logo))
        titleLabel.text = model.title
        statusLabel.text = model.statusDesc
        statusView.image = UIImage(named: model.status.statusImage)
        amountLabel.text = model.amount
        amountDescLabel.text = model.amountDesc
        timeLabel.text = model.time
        nextButton.isHidden = model.buttonTitle.isEmpty
        nextButton.setAttributedTitle(model.buttonTitle.addUnderline(), for: .normal)
        noticeLabel.text = model.notice
        noticeView.isHidden = (model.status == .review || model.status == .finish)
        nextButton.layoutImagePositionType(type: .right,spacing: 6.ratio())
    }
    
    @objc func buttonEvent(){
        model.clickCompletion?(model.linkUrl)
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
        self.model = model
    }
}
extension OrderListCell{
    struct Model {
        var id: String = ""
        var title: String = ""
        var logo: String = ""
        var amount: String = ""
        var amountDesc: String = ""
        var status: OrderStatus = .apply
        var statusDesc: String = ""
        var time: String = ""
        var timeDesc: String = ""
        var buttonTitle: String = ""
        var notice: String = ""
        var linkUrl: String = ""
        var clickCompletion: ((String)-> Void)? = nil
    }
}
