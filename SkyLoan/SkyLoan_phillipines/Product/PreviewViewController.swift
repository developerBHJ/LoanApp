//
//  PreviewViewController.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/6/11.
//

import UIKit

class PreviewViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(LocalizationConstants.Product.preview_save, for: .normal)
        button.addTarget(self, action: #selector(savePhoto), for: .touchUpInside)
        return button
    }()
    private lazy var retakeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(LocalizationConstants.Product.preview_retake, for: .normal)
        button.addTarget(self, action: #selector(retakePhoto), for: .touchUpInside)
        return button
    }()
    var completion: ((UIImage) -> Void)?
    
    init(image: UIImage,completion: ((UIImage) -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
        self.completion = completion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        // 图片预览
        imageView.contentMode = .scaleAspectFit
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80.ratio())
            make.leading.equalTo(view.snp.centerX).offset(50.ratio())
            make.height.equalTo(50.ratio())
            make.width.equalTo(100.ratio())
        }
        
        view.addSubview(retakeButton)
        retakeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80.ratio())
            make.trailing.equalTo(view.snp.centerX).offset(-50.ratio())
            make.height.equalTo(50.ratio())
            make.width.equalTo(100.ratio())
        }
    }
    
    @objc private func savePhoto() {
        guard let image = imageView.image else { return }
        self.completion?(image)
        dismiss(animated: true)
    }
    
    @objc private func retakePhoto() {
        dismiss(animated: true)
    }
}
