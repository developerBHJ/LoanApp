//
//  HomePageViewModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/16.
//

import Foundation

class HomePageViewModel {
    
    var sections: [UITableSectionModel] = []
    var infoModel: HomePageInfoModel = .init()
    var eventDelegate: HomePageEventDelegate?
    var pageOneArray: [String] = ["icon_home_product","icon_home_product1","icon_home_product2"]
    var location = LocationModel()
    
    var needLocation: Bool{
        infoModel.deed == 1
    }
    
    var isLarge: Bool{
        infoModel.romance?.general == .LARGE
    }
    
    func requestData() async{
        let result: HomePageInfoModel = await HttpRequest(HomeAPI.homeInfo,showLoading: true,keyPath: "howl")
        infoModel = result
        configData()
    }
    
    func configData(){
        sections.removeAll()
        if let model = configHeaderSection() {
            sections.append(model)
        }
        if let model = configKingKongSection() {
            sections.append(model)
        }
        if let model = configRecommondSection() {
            sections.append(model)
        }
        if let model = configProductSection() {
            sections.append(model)
        }
    }
    
    func configHeaderSection() -> UITableSectionModel? {
        guard let banner = infoModel.romance,let array = banner.winning else {return nil}
        let items: [HomeBannerItemCell.Model] = array.map { item in
            HomeBannerItemCell.Model.init(title: item.friends,amount: item.dine,duration:item.assistant, rate:item.decidedly, durationDesc: item.cut,rateDesc: item.cheer,productId: "\(item.confidential)")
        }
        let model = HomeBannerCell.Model(banner: items) {[weak self] productId in
            self?.eventDelegate?.onPushDetailView(productId: productId)
        }
        let sectionMoldel = UITableSectionModel(cellType: HomeBannerCell.self,cellDatas: [model])
        return sectionMoldel
    }
    
    func configKingKongSection() -> UITableSectionModel? {
        let model = HomeKingKongCell.Model(leftButtonTitle: LocalizationConstants.HomePage.kingKong_left,middleButtonTitle: infoModel.romance?.winning?.first?.night ?? LocalizationConstants.HomePage.kingKong_middle,rightButtonTitle: LocalizationConstants.HomePage.kingKong_right,leftButtonIcon: "icon_home_shape",middleButtonIcon: "icon_home_shape_middle",rightButtonIcon: "icon_home_shape",hideThumb: false) {[weak self] type in
            self?.kingKongEvent(type: type)
        }
        let sectionMoldel = UITableSectionModel(cellType: HomeKingKongCell.self,cellDatas: [model])
        return sectionMoldel
    }
    
    func configRecommondSection() -> UITableSectionModel?{
        guard !isLarge,let banner = infoModel.romantic,let array = banner.winning else {return nil}
        let items = array.map { item in
            HomeRecommondCell.Model.init(content: item.wondered,linkUrl: item.somehow) {[weak self] url in
                self?.eventDelegate?.onPushWebView(url: url)
            }
        }
        let model = HomeRomaticCell.Model.init(banner: items)
        let sectionMoldel = UITableSectionModel(cellType: HomeRomaticCell.self,cellDatas: [model])
        return sectionMoldel
    }
    
    func configProductSection() -> UITableSectionModel?{
        var model: HomePageProductListCell.Model?
        if isLarge,infoModel.murdering == 1{
            let array = pageOneArray.map { imageName in
                HomeProductModel.init(confidential:  infoModel.romance?.winning?.first?.confidential ?? 0,isPageOne: true, imageName: imageName)
            }
            model = HomePageProductListCell.Model.init(isLarge: isLarge,items: array,tapClosure: {[weak self] productId in
                self?.eventDelegate?.onPushDetailView(productId: productId)
            })
        }else if !isLarge,let comic = infoModel.comic,let list = comic.winning,!list.isEmpty {
            model = HomePageProductListCell.Model.init(isLarge: isLarge,items: list,tapClosure: {[weak self] productId in
                self?.eventDelegate?.onPushDetailView(productId: productId)
            })
        }
        guard let model = model else {return nil}
        let sectionMoldel = UITableSectionModel(cellType: isLarge ? HomePageProductListCell.self : HomePageProductListCell1.self,cellDatas: [model])
        return sectionMoldel
    }
    
    private func kingKongEvent(type: HomeKingKongCell.ButtonType){
        eventDelegate?.kingKongEvent(type: type)
    }
}
