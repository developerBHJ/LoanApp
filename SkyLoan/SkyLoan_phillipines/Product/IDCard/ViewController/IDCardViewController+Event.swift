//
//  IDCardViewController+Event.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/23.
//

import Foundation
import UIKit
import AVFoundation
import Photos

protocol IDCardViewEventDelegate{
    func pickerImage()
}

extension IDCardViewController: IDCardViewEventDelegate{
    
    func pickerImage() {
        if viewModel.viewType == .face{
            takeImage(type: 1)
            TrackMananger.shared.startTime(type: .face)
        }else{
            TrackMananger.shared.startTime(type: .idInfo)
            if viewModel.detailModel.general == 2{
                takeImage(type: 1)
            }else{
                showAlertView()
            }
        }
    }
    
    func showAlertView(){
        let alertView = SelectedImageAlertView(frame: .zero,model: .init(selectedCompletion: {[weak self] type in
            self?.viewModel.imageSource = type
            self?.hideProductAlertView {
                self?.takeImage(type: self?.viewModel.imageSource ?? 0)
            }
        }))
        let alertVC = ProductAlertViewController(model: .init(titleImage: "icon_Upload method",contentView: alertView, bgImage:"icon_product_alertBg1",confirmCompletion: {
            [weak self] in
            self?.takeImage(type: self?.viewModel.imageSource ?? 0)
        }))
        present(alertVC, animated: true)
    }
    
    @MainActor
    func takeImage(type: Int) {
        Task{
            if type == 1{
                if await PermissionHandle.shared.requestCameraAccess(){
                    setupCamera()
                }else{
                    showCustomAlert(title: "", message: LocalizationConstants.Alert.alertMessage_camera, confirmCompletion:  {
                        RouteManager.shared.routeTo("blue://sky.yes.app/lasagnaGiraf")
                    })
                }
            }else{
                if await PermissionHandle.shared.requestPhotoLibraryAccess(){
                    selectedImageFromPhotoLibrary()
                }else{
                    showCustomAlert(title: "", message: LocalizationConstants.Alert.alertMessage_photos, confirmCompletion:  {
                        RouteManager.shared.routeTo("blue://sky.yes.app/lasagnaGiraf")
                    })
                }
            }
        }
    }
    
    @MainActor
    func setupCamera(){
        Task{
            guard await PermissionHandle.shared.requestCameraAccess() else {return}
            let imagePicker = CustomCameraViewController(position: self.viewModel.viewType == .face ? .front : .back,canFlip: self.viewModel.viewType != .face)
            imagePicker.delegate = self
            imagePicker.presentFullScreenAndDisablePullToDismiss()
            present(imagePicker, animated: true)
        }
    }
    
    func selectedImageFromPhotoLibrary(){
        Task{
            guard await PermissionHandle.shared.requestPhotoLibraryAccess() else {return}
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
    }
    
    override func nextEvent() {
        if viewModel.viewType == .result {
            popNavigation()
        }else if viewModel.viewType == .idCard || viewModel.viewType == .face{
            if viewModel.selectedImage != nil {
                uploadImage()
            }else{
                pickerImage()
            }
        }
    }
    
    private func uploadImage(){
        var paramas: [String: Any] = [:]
        paramas["fashioned"] = viewModel.imageSource + 1
        paramas["disappointed"] = viewModel.productId
        paramas["general"] = (viewModel.viewType == .face ? 10 : 11)
        paramas["less"] = viewModel.cardType?.rawValue ?? ""
        paramas["mile"] = ""
        Task{
            let reslt = await viewModel.uploadImage(parama: paramas)
            guard reslt else {return}
            if viewModel.viewType == .idCard{
                showConfirmInfoAlertView()
            }else {
                TrackMananger.shared.endTime(type: .face)
                TrackMananger.shared.trackRisk(type: .face, productId: viewModel.productId)
                ProductEntrance.shared.onPushAuthenView()
            }
        }
    }
    
    private func saveAuthenInfo(){
        var paramas: [String: Any] = [:]
        paramas["stuff"] = viewModel.resultModel?.stuff ?? ""
        paramas["date"] = viewModel.resultModel?.date ?? ""
        paramas["nowadays"] = viewModel.resultModel?.nowadays ?? ""
        paramas["general"] = 11
        paramas["less"] = viewModel.cardType?.rawValue ?? ""
        Task{
            guard await viewModel.confirmUserInfo(parama: paramas) else {return}
            TrackMananger.shared.endTime(type: .idInfo)
            TrackMananger.shared.trackRisk(type: .idInfo, productId: viewModel.productId)
            self.hideProductAlertView() {
                ProductEntrance.shared.onPushAuthenView()
            }
        }
    }
    
    private func showConfirmInfoAlertView(){
        configConfirmView()
        let alertVC = ProductAlertViewController(model: .init(titleImage: "icon_Identity Information",contentView: confirmView,contentHeight: 400.ratio(), autoDismiss:false,confirmCompletion: {
            [weak self] in
            self?.saveAuthenInfo()
        }))
        self.confirmAlertVC = alertVC
        present(alertVC, animated: true)
    }
    
    private func configConfirmView(){
        guard let model = viewModel.resultModel else {return}
        let cellDatas = [AuthenInfoConfirmCell.Model(title: LocalizationConstants.Product.authenResultName,content: model.nowadays,valueChanged: {[weak self] name in
            self?.viewModel.resultModel?.nowadays = name
        }),AuthenInfoConfirmCell.Model.init(title: LocalizationConstants.Product.authenResultNumber,content: model.date,valueChanged: {[weak self] number in
            self?.viewModel.resultModel?.date = number
        }),AuthenInfoConfirmCell.Model.init(title: LocalizationConstants.Product.authenResultBirthday,content: model.stuff,isPicker: true,pickCompletion: {
            [weak self] in
            self?.showBirthDayPickerView()
        })]
        confirmView = AuthenticationConfirmView(frame: .zero,model: .init(cellType: AuthenInfoConfirmCell.self,contentViewHeight: 200.ratio(),dataSource: [.init(cellType: AuthenInfoConfirmCell.self,cellDatas: cellDatas)]))
    }
    
    private func showBirthDayPickerView(){
        var birthDay = Date()
        if let stuff = self.viewModel.resultModel?.stuff{
            birthDay = Date.stringToDate(stuff,dateFormat: "dd-MM-yyyy") ?? Date()
        }
        let alertView = DatePickerView.init(frame: .zero,model: .init(currentDate:birthDay,valueChanged: {[weak self] date in
            self?.viewModel.resultModel?.stuff = date
        }))
        let alertVC = ProductAlertViewController(model: .init(titleImage: "icon_Date_Selection",contentView: alertView, bgImage:"icon_product_alertBg1",contentHeight: 400.ratio(),confirmCompletion: {
            [weak self] in
            self?.updateConfirmView()
        }))
        guard let topVC = UIViewController.topMost else {return}
        topVC.present(alertVC, animated: true)
    }
    
    private func updateConfirmView(){
        self.configConfirmView()
        self.confirmAlertVC.model = .init(title: "icon_Identity Information",contentView: confirmView,contentHeight: 400.ratio(),autoDismiss: false,confirmCompletion: {
            [weak self] in
            self?.saveAuthenInfo()
        })
    }
}

extension IDCardViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: false) {
            [weak self] in
            if let image = info[.originalImage] as? UIImage{
                self?.viewModel.pickedImage = image
                self?.viewModel.selectedImage = image
            }
            self?.reloadData()
            self?.uploadImage()
        }
    }
}

extension IDCardViewController: CustomCameraViewDelegate{
    func didFinishPickingImage(image: UIImage) {
        dismiss(animated: false) {
            [weak self] in
            self?.viewModel.pickedImage = image
            self?.viewModel.selectedImage = image
            self?.reloadData()
            self?.uploadImage()
        }
    }
}
