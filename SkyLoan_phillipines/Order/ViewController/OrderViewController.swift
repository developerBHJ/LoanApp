//
//  OrderViewController.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/21.
//

import UIKit
import MJRefresh

class OrderViewController: UIViewController,BaseViewController {
    lazy var listView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        view.estimatedSectionHeaderHeight = 0
        view.estimatedSectionFooterHeight = 0
        view.estimatedRowHeight = 44.ratio()
        view.register(OrderListCell.self, forCellReuseIdentifier: OrderListCell.reusableId)
        view.register(OrderListEmptyCell.self, forCellReuseIdentifier: OrderListEmptyCell.reusableId)
        return view
    }()
    
    lazy var backImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_home_bg")
        return view
    }()
    
    lazy var navBar: CustomNavigationBar = {
        let view = CustomNavigationBar(frame: .init(x: 0, y: 0, width: kScreenW, height: kNavigationBarH))
        return view
    }()
    
    lazy var segementView: OrderSegementView = {
        let view = OrderSegementView.init(frame: .zero, model: .init(currentIndex: 0,selectedCompletion: {[weak self] type in
            self?.refreshData(type: type.typeCode)
        }))
        return view
    }()
    
    var viewModel: OrderViewModel = OrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.enventDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        hiddenNavigationBar = true
        listView.mj_header?.beginRefreshing()
    }
}

extension OrderViewController{
    var hiddenNavigationBar: Bool{
        true
    }
    
    func setupUI(){
        view.addSubview(backImageView)
        navBar.title = LocalizationConstants.Order.nav_title
        
        backImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(navBar)
        view.addSubview(segementView)
        segementView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom).offset(12.ratio())
            make.leading.trailing.equalToSuperview().inset(16.ratio())
            make.height.equalTo(42.ratio())
        }
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.top.equalTo(segementView.snp.bottom).offset(12.ratio())
            make.leading.trailing.bottom.equalToSuperview()
        }
        listView.mj_header = MJRefreshHeader(refreshingBlock: {
            [weak self] in
            self?.reloadData()
        })
    }
    
    @MainActor
    func reloadData(){
        Task{
            await viewModel.reloadData()
            listView.reloadData()
            await listView.mj_header?.endRefreshing()
        }
    }
}

extension OrderViewController: UITableViewDelegate,UITableViewDataSource{
    
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
        let sectionModel = viewModel.dataSource[indexPath.section]
        if let model = sectionModel.cellDatas?[indexPath.row] as? OrderListCell.Model {
            onPushOrderDetail(url: model.linkUrl)
        }
    }
}

