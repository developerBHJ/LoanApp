//
//  HomeRomaticCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/21.
//

import UIKit
import FSPagerView

class HomeRomaticCell: UITableViewCell {
    
    lazy var bannerView: FSPagerView = {
        let view = FSPagerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(HomeRecommondCell.self, forCellWithReuseIdentifier: "HomeRecommondCell")
        view.itemSize = .init(width: kScreenW, height: 65.ratio())
        view.automaticSlidingInterval = 3
        return view
    }()
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeRomaticCell{
    func setupUI(){
        backgroundColor = .clear
        contentView.addSubview(bannerView)
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 65.ratio())
        ])
    }
    
    func applyModel(){
        bannerView.reloadData()
    }
    
    override func configData(data: Any?) {
        guard let model = data as? Model else {return}
        self.model = model
    }
}

extension HomeRomaticCell: FSPagerViewDelegate,FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        model.banner.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "HomeRecommondCell", at: index)
        let item = model.banner[index]
        cell.configData(data: item)
        return cell
    }
}

extension HomeRomaticCell{
    struct Model {
        var banner:[HomeRecommondCell.Model] = []
        var didSelected: ((String) -> Void)? = nil
    }
}
