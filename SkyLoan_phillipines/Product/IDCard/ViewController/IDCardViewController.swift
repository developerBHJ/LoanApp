//
//  IDCardViewController.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/23.
//

import UIKit

class IDCardViewController: AuthenticationBaseController {
    
    convenience init(viewType: IDcardType = .idCard,title: String,productId: String,detailModel: ProductInfoModel? = nil,cardType: VertifyType? = nil){
        self.init()
        viewModel.productId = productId
        viewModel.viewType = viewType
        if let cardType = cardType {
            viewModel.cardType = cardType
        }else if let model = detailModel{
            viewModel.detailModel = model
            viewModel.cardType = model.strenuous?.less
        }
        navTitle = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.configData()
        reloadData()
        viewModel.eventDelegate = self
    }
    
    override func popNavigation(animated: Bool = true) {
        super.popNavigation(animated: animated)
        if let rootVC = navigationController?.children.first(where: {$0 is ProductHomeViewController}) {
            navigationController?.popToViewController(rootVC, animated: true)
        }
    }
    
    
    private var navTitle = ""
    var viewModel: IDCardViewModel = .init()
    
    lazy var headerView: ProductHomeHeaderView = {
        let view = ProductHomeHeaderView(frame: .init(x: 0, y: 0, width: kScreenW, height: 150.ratio()),model: .init(slogn: "",hideProgress: true))
        return view
    }()
    
    var confirmView: AuthenticationConfirmView = .init(frame: .zero, model: .init())
    var confirmAlertVC: ProductAlertViewController = .init()
}

extension IDCardViewController{
    override func setupUI() {
        super.setupUI()
        navBar.title = navTitle
        nextButton.setAttributedTitle(LocalizationConstants.Product.bottomButtonTitle.addUnderline(), for: .normal)
        listView.register(IDCardCell.self, forCellReuseIdentifier: IDCardCell.reusableId)
        listView.register(IDCardResultCell.self, forCellReuseIdentifier: IDCardResultCell.reusableId)
        listView.delegate = self
        listView.dataSource = self
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom).offset(12.ratio())
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150.ratio())
        }
        let slogn = (viewModel.viewType == .face) ? LocalizationConstants.Product.faceSlogn : LocalizationConstants.Product.idCardSlogn
        headerView.model = .init(slogn: slogn,hideProgress: true,isResult: viewModel.viewType == .result)
        listView.snp.remakeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        if viewModel.viewType == .result{
            nextButton.setAttributedTitle(LocalizationConstants.Product.idCardBottomButtonTitle1.addUnderline(), for: .normal)
        }else{
            nextButton.setAttributedTitle(LocalizationConstants.Product.idCardBottomButtonTitle.addUnderline(), for: .normal)
        }
        view.bringSubviewToFront(childImageView)
    }
    
    override func reloadData() {
        viewModel.reloadData()
        listView.reloadData()
    }
    
    var hiddenNavigationBar: Bool{
        true
    }
}

extension IDCardViewController: UITableViewDelegate,UITableViewDataSource{
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
