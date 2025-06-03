//
//  HomePageViewController.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/14.
//

import UIKit
import MJRefresh

class HomePageViewController: UIViewController {
    
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
        view.register(HomeBannerCell.self, forCellReuseIdentifier: HomeBannerCell.reusableId)
        view.register(HomeKingKongCell.self, forCellReuseIdentifier: HomeKingKongCell.reusableId)
        view.register(HomeRomaticCell.self, forCellReuseIdentifier: HomeRomaticCell.reusableId)
        view.register(HomePageProductListCell.self, forCellReuseIdentifier: HomePageProductListCell.reusableId)
        view.register(HomePageProductListCell1.self, forCellReuseIdentifier: HomePageProductListCell1.reusableId)
        return view
    }()
    
    lazy var bgImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_home_bg")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var profileButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_home_mine"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showDrawerView), for: .touchUpInside)
        return button
    }()
    
    lazy var orderButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_home_order"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onPushOrderView), for: .touchUpInside)
        return button
    }()
    
    var viewModel = HomePageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        ADTool.shared.registerIDFA()
        viewModel.eventDelegate = self
        RouteManager.shared.regisetrRoutes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        hiddenNavigationBar = true
        listView.mj_header?.beginRefreshing()
        _ = LoginTool().checkLogin(needLogin: true)
    }
}

extension HomePageViewController: BaseViewController{
    func setupUI(){
        view.backgroundColor = .white
        view.addSubview(bgImageView)
        view.addSubview(listView)
        view.addSubview(profileButton)
        view.addSubview(orderButton)
        listView.contentInsetAdjustmentBehavior = .never
        let headerView = UIView(frame: .init(x: 0, y: 0, width: kScreenW, height: kStatusBarH))
        headerView.backgroundColor = .clear
        listView.tableHeaderView = headerView
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            listView.topAnchor.constraint(equalTo: view.topAnchor),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            profileButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.ratio()),
            profileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.ratio()),
            profileButton.widthAnchor.constraint(equalToConstant: 120.ratio()),
            profileButton.heightAnchor.constraint(equalToConstant: 54.ratio()),
            
            orderButton.bottomAnchor.constraint(equalTo: profileButton.topAnchor, constant: -10.ratio()),
            orderButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.ratio()),
            orderButton.widthAnchor.constraint(equalToConstant: 120.ratio()),
            orderButton.heightAnchor.constraint(equalToConstant: 54.ratio()),
        ])
        listView.mj_header = MJRefreshHeader(refreshingBlock: {
            [weak self] in
            self?.reloadData()
        })
    }
    
    @MainActor
    func reloadData(){
        Task{
            await viewModel.requestData()
            await listView.mj_header?.endRefreshing()
            listView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
}

extension HomePageViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = viewModel.sections[section]
        return sectionModel.cellDatas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = viewModel.sections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionModel.cellType.reusableId)
        if let model = sectionModel.cellDatas?[indexPath.row]{
            cell?.data = model
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 16.ratio() : 0
    }
}
