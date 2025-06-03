//
//  CapsuleProgressBar.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/22.
//

import UIKit
class CapsuleProgressBar: UIView {
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = SLFont(size: 12, weight: .black)
        label.textAlignment = .center
        return label
    }()
    
    // 进度条背景层
    private let backgroundLayer = CAShapeLayer()
    // 进度条前景层
    private let progressLayer = CAShapeLayer()
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
    
    private var progress: CGFloat = 0{
        didSet{
            updateProgress()
        }
    }
    private var trackColor: UIColor = .white
    private var progressColor: UIColor = .white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyModel()
        setupLayers()
        setupUI()
    }
    
    init(frame: CGRect,model: Model = .init()) {
        super.init(frame: frame)
        self.model = model
        applyModel()
        setupLayers()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 更新图层路径
        let backgroundPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: model.cornerRadius
        )
        backgroundLayer.path = backgroundPath.cgPath
    }
}

extension CapsuleProgressBar{
    func setupUI(){
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func applyModel(){
        label.text = "\(model.current) / \(model.total)"
        label.textColor = model.textColor
        label.font = model.textFont
        progressColor = model.progressColor
        trackColor = model.trackColor
        layer.cornerRadius = model.cornerRadius
        layer.masksToBounds = true
        if model.total > 0{
            progress = CGFloat(model.current) / CGFloat(model.total)
        }
    }
    
    private func updateProgress() {
        // 计算进度宽度
        let progressWidth = bounds.width * progress
        // 创建进度路径
        let progressRect = CGRect(
            x: 0,
            y: 0,
            width: progressWidth,
            height: bounds.height
        )
        let progressPath = UIBezierPath(
            roundedRect: progressRect,
            byRoundingCorners: [.topLeft, .bottomLeft],
            cornerRadii: CGSize(width: model.cornerRadius, height: model.cornerRadius)
        )
        // 应用动画
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.3)
        progressLayer.path = progressPath.cgPath
        CATransaction.commit()
    }
    
    private func setupLayers() {
        // 配置背景层
        backgroundLayer.fillColor = trackColor.cgColor
        layer.addSublayer(backgroundLayer)
        // 配置进度层
        progressLayer.fillColor = progressColor.cgColor
        layer.addSublayer(progressLayer)
    }
}

extension CapsuleProgressBar{
    struct Model {
        var current: Int = 0
        var total: Int = 0
        var cornerRadius: CGFloat = 0
        let progressColor: UIColor = kColor_A0EB3F ?? .white
        let trackColor: UIColor = kColor_288100 ?? .white
        var textColor: UIColor = .white
        let textFont: UIFont = SLFont(size: 12, weight: .black)
    }
}
