//
//  ProductHomeHeaderView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/22.
//

import UIKit
class ProductHomeHeaderView: UIView {
    
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
    
    lazy var progressBar: CapsuleProgressBar = {
        let view = CapsuleProgressBar(frame: .zero,model: .init(cornerRadius: 8.5.ratio()))
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = SLFont(size: 19, weight: .black)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var waveView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_wave")
        return view
    }()
    
    lazy var resultView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_idCard_result_header")
        return view
    }()
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
}

extension ProductHomeHeaderView{
    func setupUI(){
        backgroundColor = .clear
        addSubview(resultView)
        resultView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12.ratio())
            make.leading.equalToSuperview().inset(3.ratio())
            make.width.equalTo(252.ratio())
            make.height.equalTo(108.ratio())
        }
        addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.ratio())
            make.leading.equalToSuperview().inset(16.ratio())
            make.width.equalTo(111.ratio())
            make.height.equalTo(17.ratio())
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(13.ratio())
            make.trailing.leading.equalToSuperview().inset(16.ratio())
        }
        addSubview(waveView)
        waveView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10.ratio())
            make.bottom.equalTo(titleLabel).offset(2.ratio())
        }
        self.sendSubviewToBack(waveView)
    }
    
    func applyModel(){
        progressBar.model = .init(current: model.current,total: model.total,cornerRadius: 8.5.ratio())
        titleLabel.text = model.slogn
        progressBar.isHidden = model.hideProgress
        let bottomSpace = model.hideProgress ? 16.ratio() : 2.ratio()
        waveView.snp.updateConstraints { make in
            make.bottom.equalTo(titleLabel).offset(bottomSpace)
        }
        resultView.isHidden = !model.isResult
        waveView.isHidden = model.isResult
        titleLabel.isHidden = model.isResult
        setNeedsLayout()
    }
}
extension ProductHomeHeaderView{
    struct Model {
        var current: Int = 0
        var total: Int = 0
        var slogn: String = ""
        var hideProgress: Bool = false
        var isResult: Bool = false
    }
}
