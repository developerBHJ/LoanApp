//
//  IDCardViewModel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/23.
//

import Foundation
import UIKit

enum IDcardType {
    case idCard
    case face
    case result
    case selectCarType
}

class IDCardViewModel {
    var productId: String = ""
    var viewType: IDcardType = .idCard
    var dataSource: [UITableSectionModel] = []
    var pickedImage: UIImage? = nil
    var eventDelegate: IDCardViewEventDelegate?
    var imageSource: Int = 1
    var detailModel: ProductInfoModel = .init()
    var cardType: VertifyType?
    var resultModel: PsychologicallyModel?
    
    func configData(){
        pickedImage = (viewType == .face) ? UIImage(named: "icon_face_example") : UIImage(named: "icon_product_example")
    }
    
    func reloadData() {
        if viewType == .result{
            if let psychologically = detailModel.strenuous?.psychologically{
                let model = IDCardResultCell.Model.init(items: [.init(title: LocalizationConstants.Product.authenInfoName,content: psychologically.nowadays),.init(title: LocalizationConstants.Product.authenInfoNumber,content: psychologically.date),.init(title: LocalizationConstants.Product.authenInfoBirthday,content: psychologically.stuff)])
                let sectionModel = UITableSectionModel.init(cellType: IDCardResultCell.self,cellDatas: [model])
                dataSource = [sectionModel]
            }
        }else{
            let tips = (viewType == .face) ? LocalizationConstants.Product.faceTips : LocalizationConstants.Product.idCardTips
            let noticeTitle = (viewType == .face) ? LocalizationConstants.Product.faceRequireTitle : LocalizationConstants.Product.idCardRequireTitle
            let notice = (viewType == .face) ? LocalizationConstants.Product.faceRequire : LocalizationConstants.Product.idCardRequire
            let items =  (viewType == .face) ? ["icon_face_error","icon_face_error1","icon_face_error2"] :  ["icon_idCard_error","icon_idCard_error1","icon_idCard_error2"]
            let model = IDCardCell.Model.init(image: pickedImage,tips: tips,noticeTitle: noticeTitle,notice: notice,items: items){
                [weak self] in
                self?.eventDelegate?.pickerImage()
            }
            let sectionModel = UITableSectionModel.init(cellType: IDCardCell.self,cellDatas: [model])
            dataSource = [sectionModel]
        }
    }
    
    func uploadImage(parama:[String: Any]) async -> Bool{
        guard let image = pickedImage else {return false}
        if viewType == .face {
            let reslt: [String: Any]? = await HttpRequestDictionary(UploadService.uploadProfile(image: image, meta: parama),showLoading: true,showMessage: true)
            if let extraordinarily = reslt?["extraordinarily"] as? Int,extraordinarily == 9{
                return true
            }
        }else if viewType == .idCard{
            let reslt: PsychologicallyModel? = await HttpRequest(UploadService.uploadProfile(image: image, meta: parama),showLoading: true,showMessage: true)
            resultModel = reslt
            return true
        }
        return false
    }
    
    func confirmUserInfo(parama:[String: Any]) async -> Bool{
        let result: [String: Any]? = await HttpRequestDictionary(ProductAPI.saveAuthenInfo(body: parama),showLoading: true,showMessage: true)
        return result != nil
    }
}
