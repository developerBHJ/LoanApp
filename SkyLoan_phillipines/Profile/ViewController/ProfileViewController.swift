//
//  ProfileViewController.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/14.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.configData()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hiddenNavigationBar = true
    }
    
    override func popNavigation(animated: Bool = true) {
        if let _ = self.presentingViewController {
            dismiss(animated: animated,completion: completion)
        }else{
            navigationController?.popViewController(animated: animated)
            completion?()
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_profile_bg")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_profile_back"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backEvent), for: .touchUpInside)
        return button
    }()
    
    lazy var headerView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_profile_header")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20.ratio()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nickName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = SLFont(size: 17, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var versionView: VersionView = {
        let view = VersionView(frame: .zero,model: .init())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel = ProfileViewModel()
    var completion: (()-> Void)? = nil
}

extension ProfileViewController: BaseViewController{
    
    func setupUI(){
        view.backgroundColor = Constant.backColor
        view.addSubView(view: bgImageView,topConstant: 0,trailingConstant: 0,bottomConstant: 0,width: kScreenW - 72.ratio())
        view.addSubview(backButton)
        view.addSubview(headerView)
        view.addSubview(stackView)
        headerView.addSubview(nickName)
        view.addSubview(versionView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 120.ratio() - view.safeAreaInsets.top),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.widthAnchor.constraint(equalToConstant: 202.ratio()),
            headerView.heightAnchor.constraint(equalToConstant: 67.5.ratio()),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 4.ratio()),
            backButton.leadingAnchor.constraint(equalTo: bgImageView.leadingAnchor, constant: 50.ratio()),
            backButton.widthAnchor.constraint(equalToConstant: 51.ratio()),
            backButton.heightAnchor.constraint(equalToConstant: 51.ratio()),
            
            nickName.topAnchor.constraint(equalTo: headerView.topAnchor),
            nickName.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 69.ratio()),
            nickName.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            nickName.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -10.ratio()),
            
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 47.ratio()),
            stackView.trailingAnchor.constraint(equalTo: bgImageView.trailingAnchor, constant: -20.ratio()),
            stackView.leadingAnchor.constraint(equalTo: bgImageView.leadingAnchor, constant: 20.ratio()),
            
            versionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.ratio()),
            versionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -22.ratio()),
        ])
        stackView.removeAllSubViews()
        let items: [ProfileListItem] = viewModel.dataSource.map { model in
            ProfileListItem.init(frame: .zero, model: .init(title: model.title,icon: model.icon,originX: model.originX,linkUrl: model.type.linkUrl,rightArrow:model.rightArrow, textColor: model.type == .logOff ? kColor_black.withAlphaComponent(0.5) : kColor_black,type: model.type,tapCompletion: {[weak self] type in
                self?.itemClick(type: type)
            }))
        }
        stackView.addSubViews(views: items)
        nickName.text = LoginTool.shared.getUserName().safePhoneNumber()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
}
