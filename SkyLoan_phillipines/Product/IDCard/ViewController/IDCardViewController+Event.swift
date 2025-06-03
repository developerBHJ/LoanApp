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
        if viewModel.detailModel.general == 2{
            takeImage(type: 1)
        }else{
            showAlertView()
        }
        TrackMananger.shared.startTime = CFAbsoluteTimeGetCurrent()
    }
    
    func showAlertView(){
        let alertView = SelectedImageAlertView(frame: .zero,model: .init(selectedCompletion: {[weak self] type in
            self?.viewModel.imageSource = type
        }))
        let alertVC = ProductAlertViewController(model: .init(titleImage: "icon_Upload method",contentView: alertView, bgImage:"icon_product_alertBg1",confirmCompletion: {
            [weak self] in
            self?.takeImage(type: self?.viewModel.imageSource ?? 0)
        }))
        present(alertVC, animated: true)
    }
    
    func takeImage(type: Int) {
        if type == 1{
            setupCamera()
        }else{
            selectedImageFromPhotoLibrary()
        }
    }
    
    @MainActor
    func setupCamera(){
        Task{
            guard await PermissionHandle.shared.requestCameraAccess() else {return}
            if viewModel.viewType == .face{
                let imagePicker = CustomCameraViewController()
                imagePicker.delegate = self
                imagePicker.presentFullScreenAndDisablePullToDismiss()
                present(imagePicker, animated: true)
            }else{
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.cameraDevice = .front
                imagePicker.allowsEditing = false
                present(imagePicker, animated: true)
            }
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
            uploadImage()
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
            if reslt,viewModel.viewType == .idCard{
                showConfirmInfoAlertView()
            }else {
                TrackMananger.shared.endTime = CFAbsoluteTimeGetCurrent()
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
            TrackMananger.shared.endTime = CFAbsoluteTimeGetCurrent()
            TrackMananger.shared.trackRisk(type: .idInfo, productId: viewModel.productId)
            ProductEntrance.shared.onPushAuthenView()
        }
    }
    
    private func showConfirmInfoAlertView(){
        configConfirmView()
        let alertVC = ProductAlertViewController(model: .init(titleImage: "icon_Identity Information",contentView: confirmView,contentHeight: 400.ratio(),confirmCompletion: {
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
        let alertView = DatePickerView.init(frame: .zero,model: .init(valueChanged: {[weak self] date in
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
        self.confirmAlertVC.model = .init(title: "icon_Identity Information",contentView: confirmView,contentHeight: 400.ratio(),confirmCompletion: {
            [weak self] in
            self?.saveAuthenInfo()
        })
    }
}

extension IDCardViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            viewModel.pickedImage = image
        }
        dismiss(animated: true)
        reloadData()
    }
}

extension IDCardViewController: CustomCameraViewDelegate{
    func didFinishPickingImage(image: UIImage) {
        dismiss(animated: true)
        viewModel.pickedImage = image
        reloadData()
    }
}
