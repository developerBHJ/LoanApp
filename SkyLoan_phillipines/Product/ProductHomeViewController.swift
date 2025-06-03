//
//  ProductHomeViewController.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/22.
//

import UIKit
import MJRefresh

class ProductHomeViewController: AuthenticationBaseController {
    convenience init(productId: String,orderNum: String){
        self.init()
        viewModel.productId = productId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.eventDelegate = self
        Task{
           await LoginTool.shared.requestAddressList()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        hiddenNavigationBar = true
        listView.mj_header?.beginRefreshing()
    }
    
    var viewModel = ProductViewModel()
    
    lazy var headerView: ProductHomeHeaderView = {
        let view = ProductHomeHeaderView(frame: .init(x: 0, y: 0, width: kScreenW, height: 120.ratio()),model: .init())
        view.isHidden = true
        return view
    }()
}

extension ProductHomeViewController{
    var hiddenNavigationBar: Bool{
        true
    }
    
    override func setupUI(){
        super.setupUI()
        navBar.title = LocalizationConstants.Product.nav_title
        listView.register(ProductListCell.self, forCellReuseIdentifier: ProductListCell.reusableId)
        listView.delegate = self
        listView.dataSource = self
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom).offset(12.ratio())
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120.ratio())
        }
        listView.snp.remakeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        nextButton.setAttributedTitle(LocalizationConstants.Product.bottomButtonTitle.addUnderline(), for: .normal)
        listView.mj_header = MJRefreshHeader(refreshingBlock: {
            [weak self] in
            self?.reloadData()
        })
        view.bringSubviewToFront(navBar)
    }
    
    @MainActor
    override func reloadData(){
        Task{
            await viewModel.reloadData()
            headerView.model = viewModel.headerModel
            headerView.isHidden = false
            listView.reloadData()
            await listView.mj_header?.endRefreshing()
            guard let url = viewModel.getUrl(),!url.isEmpty else {return}
            HJPrint(url)
        }
    }
}

extension ProductHomeViewController: UITableViewDelegate,UITableViewDataSource{
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.itemList.count > indexPath.row else {return}
        let model = viewModel.itemList[indexPath.row]
        itemClick(model: model)
    }
}


