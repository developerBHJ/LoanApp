//
//  HomeBannerCell.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/15.
//

import UIKit
import Kingfisher
import FSPagerView

class HomeBannerCell: UITableViewCell {
    
    lazy var bannerView: FSPagerView = {
        let view = FSPagerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(HomeBannerItemCell.self, forCellWithReuseIdentifier: "HomeBannerItemCell")
        view.itemSize = .init(width: kScreenW, height: 245.ratio())
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

extension HomeBannerCell{
    func setupUI(){
        backgroundColor = .clear
        contentView.addSubview(bannerView)
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 245.ratio())
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

extension HomeBannerCell: FSPagerViewDelegate,FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        model.banner.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "HomeBannerItemCell", at: index)
        let url = model.banner[index]
        cell.imageView?.kf.setImage(with: URL.init(string: url))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        model.didSelected?(index)
    }
}

extension HomeBannerCell{
    struct Model {
        var banner:[String] = []
        var didSelected: ((Int) -> Void)? = nil
    }
}
