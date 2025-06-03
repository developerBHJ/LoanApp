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
        guard let banner = infoModel.anybody,let array = banner.winning else {return nil}
        let items: [String] = array.map { item in
            item.hair
        }
        let model = HomeBannerCell.Model(banner: items) {[weak self] index in
            self?.eventDelegate?.onPushWebView(url: items[index])
        }
        let sectionMoldel = UITableSectionModel(cellType: HomeBannerCell.self,cellDatas: [model])
        return sectionMoldel
    }
    
    func configKingKongSection() -> UITableSectionModel? {
        let model = HomeKingKongCell.Model(leftButtonTitle: LocalizationConstants.HomePage.kingKong_left,middleButtonTitle: LocalizationConstants.HomePage.kingKong_middle,rightButtonTitle: LocalizationConstants.HomePage.kingKong_right,leftButtonIcon: "icon_home_shape",middleButtonIcon: "icon_home_shape_middle",rightButtonIcon: "icon_home_shape",hideThumb: false) {[weak self] type in
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
        let model = HomeRomaticCell.Model.init(banner: items) {[weak self] url in
            self?.eventDelegate?.onPushWebView(url: url)
        }
        let sectionMoldel = UITableSectionModel(cellType: HomeRomaticCell.self,cellDatas: [model])
        return sectionMoldel
    }
    
    func configProductSection() -> UITableSectionModel?{
        var model: HomePageProductListCell.Model?
        if isLarge,let romance = infoModel.romance,let list = romance.winning,!list.isEmpty {
            model = HomePageProductListCell.Model.init(isLarge: true,items: list,tapClosure: {[weak self] url in
                self?.eventDelegate?.onPushWebView(url: url)
            })
        }else if !isLarge,let comic = infoModel.comic,let list = comic.winning,!list.isEmpty{
            model = HomePageProductListCell.Model.init(isLarge: false,items: list,tapClosure: {[weak self] id in
                self?.eventDelegate?.onPushDetailView(productId: id)
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
