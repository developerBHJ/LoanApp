//
//  HomeBannerItemCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/15.
//

import UIKit
import FSPagerView

class HomeBannerItemCell: FSPagerViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.selectedBackgroundView = nil
        setupUI()
        applyModel()
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_home_banner_bg")
        return view
    }()
    
    lazy var noticeBgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_home_banner_notice")
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_black
        label.font = SLFont(size: 19, weight: .black)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_black
        label.font = SLFont(size: 30, weight: .bold)
        return label
    }()
    
    lazy var durationDescLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_black
        label.font = SLFont(size: 9, weight: .bold)
        return label
    }()
    
    lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blue
        label.font = SLFont(size: 9, weight: .bold)
        return label
    }()
    
    lazy var rateDescLabel: UILabel = {
        let label = UILabel()
        label.textColor = kColor_black
        label.font = SLFont(size: 9, weight: .bold)
        return label
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blue
        label.font = SLFont(size: 9, weight: .bold)
        return label
    }()
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
}

extension HomeBannerItemCell{
    
    func setupUI(){
        backgroundColor = .clear
        self.contentView.layer.shadowRadius = 0
        self.contentView.layer.shadowOpacity = 0
        self.contentView.layer.shadowOffset = .zero
        self.contentView.layer.shadowColor = UIColor.clear.cgColor
        self.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(78.ratio())
            make.leading.equalToSuperview().inset(155.ratio())
            make.trailing.equalToSuperview().inset(16.ratio())
        }
        
        self.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12.ratio())
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(titleLabel)
            make.height.equalTo(55.ratio())
        }
        
        self.addSubview(noticeBgView)
        noticeBgView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(108.ratio())
            make.trailing.equalToSuperview().inset(20.ratio())
            make.height.equalTo(42.ratio())
        }
        
        noticeBgView.addSubview(durationDescLabel)
        noticeBgView.addSubview(durationLabel)
        durationDescLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.ratio())
            make.centerY.equalToSuperview().offset(-5.ratio())
        }
        durationLabel.snp.makeConstraints { make in
            make.leading.equalTo(durationDescLabel.snp.trailing)
            make.centerY.equalToSuperview().offset(-5.ratio())
        }
        
        noticeBgView.addSubview(rateDescLabel)
        noticeBgView.addSubview(rateLabel)
        rateDescLabel.snp.makeConstraints { make in
            make.leading.equalTo(durationLabel.snp.trailing).offset(8.ratio())
            make.centerY.equalToSuperview().offset(-3.ratio())
        }
        
        rateLabel.snp.makeConstraints { make in
            make.leading.equalTo(rateDescLabel.snp.trailing)
            make.centerY.equalToSuperview()
        }
    }
    
    func applyModel(){
        titleLabel.text = model.title
        amountLabel.text = model.amount
        durationDescLabel.text = model.durationDesc + ": "
        durationLabel.text = model.duration
        rateDescLabel.text = model.rateDesc + ": "
        rateLabel.text = model.rate
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
        self.model = model
    }
}

extension HomeBannerItemCell{
    struct Model {
        var title: String = ""
        var amount: String = ""
        var duration: String = ""
        var rate: String = ""
        var durationDesc: String = ""
        var rateDesc: String = ""
        var productId: String = ""
    }
}
