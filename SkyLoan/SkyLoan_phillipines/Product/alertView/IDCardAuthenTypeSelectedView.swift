//
//  IDCardAuthenTypeSelectedView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/25.
//

import UIKit

class IDCardAuthenTypeSelectedView: UIView {
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
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
    
    lazy var listView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.estimatedSectionHeaderHeight = 0
        view.estimatedSectionFooterHeight = 0
        view.estimatedRowHeight = 44.ratio()
        return view
    }()
}

extension IDCardAuthenTypeSelectedView{
    func setupUI(){
        backgroundColor = .clear
        addSubview(listView)
        listView.delegate = self
        listView.dataSource = self
        listView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(12.ratio())
            make.height.equalTo(0)
            make.bottom.equalToSuperview()
        }
    }
    
    func applyModel(){
        listView.register(model.cellType, forCellReuseIdentifier: model.cellType.reusableId)
        listView.reloadData()
        listView.snp.makeConstraints { make in
            make.height.equalTo(model.contentViewHeight)
        }
    }
}

extension IDCardAuthenTypeSelectedView{
    struct Model {
        var cellType: UITableViewCell.Type = UITableViewCell.self
        var contentViewHeight: CGFloat = 200.ratio()
        var dataSource: [UITableSectionModel] = []
        var selectedCompletion: ((String) -> Void)? = nil
    }
}

extension IDCardAuthenTypeSelectedView: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        model.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = model.dataSource[section]
        return sectionModel.cellDatas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = model.dataSource[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: sectionModel.cellType.reusableId)
        if let model = sectionModel.cellDatas?[indexPath.row]{
            cell?.data = model
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var sectionModel = model.dataSource[indexPath.section]
        var newCellModels: [Any] = []
        if let cellModel = sectionModel.cellDatas as? [IDCardAuthenTypeCell.Model]{
            cellModel.enumerated().forEach(({ index,m in
                var newModel = m
                newModel.isSelected = (index == indexPath.row)
                if newModel.isSelected{
                    model.selectedCompletion?(newModel.title)
                }
                newCellModels.append(newModel)
            }))
        }
        sectionModel.cellDatas = newCellModels
        model.dataSource.replaceSubrange(indexPath.section ..< indexPath.section + 1, with: [sectionModel])
        listView.reloadData()
    }
}

