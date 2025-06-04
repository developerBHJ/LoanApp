//
//  PersonalInfoViewController.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/27.
//

import UIKit
class PersonalInfoViewController: AuthenticationBaseController {
    
    convenience init(title: String,productId: String){
        self.init()
        self.viewModel.productId = productId
        self.navTitle = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        reloadData()
        viewModel.eventDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TrackMananger.shared.startTime = CFAbsoluteTimeGetCurrent()
        IQKeyboardManager.shared().isEnabled = true
    }
    
    override func popNavigation(animated: Bool = true) {
        if let rootVC = navigationController?.children.first(where: {$0 is ProductHomeViewController}) {
            navigationController?.popToViewController(rootVC, animated: true)
        }
    }
    
    var viewModel: PersonalInfoViewModel = .init()
    private var navTitle: String = ""
    
    lazy var headerView: PersonalBasicHeaderView = {
        let view = PersonalBasicHeaderView(frame: .init(x: 0, y: 0, width: kScreenW, height: 113.ratio()))
        return view
    }()
}

extension PersonalInfoViewController{
    
    override func setupUI(){
        super.setupUI()
        listView.delegate = self
        listView.dataSource = self
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(113.ratio())
        }
        listView.snp.remakeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-getNotchHeight()-56.ratio())
        }
        listView.register(PersonalBasicInfoCell.self, forCellReuseIdentifier: PersonalBasicInfoCell.reusableId)
        navBar.title = navTitle
        navBar.backgroundColor = .white
        childImageView.isHidden = true
        nextButton.setAttributedTitle(LocalizationConstants.Product.nextStep.addUnderline(), for: .normal)
    }
    
    @MainActor
    override func reloadData() {
        Task{
            await viewModel.reloadData()
            listView.reloadData()
            updateHeaderView()
        }
    }
    
    @MainActor
    func updateHeaderView(){
        let model =  PersonalBasicHeaderView.Model.init(title: navTitle,imageName: "icon_product_basic",current: viewModel.editData.count,total: viewModel.itemList.count)
        headerView.model = model
    }
}

extension PersonalInfoViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = viewModel.dataSource[section]
        return sectionModel.cellDatas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = viewModel.dataSource[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionModel.cellType.reusableId)
        if let model = sectionModel.cellDatas?[indexPath.row]{
            cell?.data = model
        }
        return cell ?? UITableViewCell()
    }
}
