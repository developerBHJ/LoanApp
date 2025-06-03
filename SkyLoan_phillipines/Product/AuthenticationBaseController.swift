//
//  AuthenticationBaseController.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/23.
//

import UIKit

class AuthenticationBaseController: UIViewController,BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hiddenNavigationBar = true
    }
    
    lazy var navBar: CustomNavigationBar = {
        let view = CustomNavigationBar(frame: .init(x: 0, y: 0, width: kScreenW, height: kNavigationBarH))
        return view
    }()
    
    lazy var backImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_home_bg")
        return view
    }()
    
    lazy var childImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_product_child")
        return view
    }()
    
    lazy var listView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.estimatedSectionHeaderHeight = 0
        view.estimatedSectionFooterHeight = 0
        view.estimatedRowHeight = 44.ratio()
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = SLFont(size: 17, weight: .black)
        button.addTarget(self, action: #selector(nextEvent), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "icon_product_button"), for: .normal)
        return button
    }()
}

extension AuthenticationBaseController{
    
    @objc func nextEvent(){
        
    }
    
   @objc func setupUI(){
        view.addSubview(backImageView)
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(navBar)
        view.addSubview(childImageView)
        childImageView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.trailing.equalToSuperview().inset(16.ratio())
            make.width.equalTo(178.ratio())
            make.height.equalTo(165.ratio())
        }
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom).offset(12.ratio())
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-getNotchHeight()-56.ratio())
        }
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(41.ratio())
            make.bottom.equalToSuperview().inset(getNotchHeight())
            make.height.equalTo(56.ratio())
        }
        view.bringSubviewToFront(navBar)
    }
    
    
    @MainActor
   @objc func reloadData(){}
}
