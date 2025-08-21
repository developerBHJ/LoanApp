//
//  BPImagePiakerViewController.swift
//  BilisPera
//
//  Created by BHJ on 2025/8/18.
//

import UIKit
import AVFoundation

class BPImagePiakerViewController: UIViewController {
    
    // MARK: - 属性
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var currentCamera: AVCaptureDevice!
    private var photoOutput: AVCapturePhotoOutput!
    
    // MARK: - UI组件
    private let captureButton = UIButton()
    private let flashButton = UIButton()
    private var position: AVCaptureDevice.Position = .back
    private lazy var flipButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "camera.rotate"), for: .normal)
        button.addTarget(self, action: #selector(flipCamera), for: .touchUpInside)
        button.tintColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.init(named: "icon_nav_back")?.withTintColor(UIColor.white), for: .normal)
        button.addTarget(self, action: #selector(backEvent), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc
    var completion: ((UIImage) -> Void)?
    @objc
    var canFlip: Bool = false
    
    @objc
    convenience init(position: AVCaptureDevice.Position,canFlip: Bool = false){
        self.init()
        self.position = position
        self.canFlip = canFlip
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCamera()
    }
    
    // MARK: - 相机配置
    @MainActor
    private func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: self.position) else {
            return
        }
        currentCamera = device
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
            photoOutput = AVCapturePhotoOutput()
            if captureSession.canAddOutput(photoOutput) {
                captureSession.addOutput(photoOutput)
            }
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = view.bounds
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.insertSublayer(previewLayer, at: 0)
            self.captureSession.startRunning()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - 拍照功能
    private func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        if currentCamera.hasFlash {
            settings.flashMode = flashButton.isSelected ? .on : .off
        }
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    // MARK: - UI设置
    private func setupUI() {
        // 拍照按钮配置
        captureButton.frame = CGRect(
            x: view.center.x - 35,
            y: view.bounds.height - 100,
            width: 70,
            height: 70
        )
        captureButton.backgroundColor = .white
        captureButton.layer.cornerRadius = 35
        captureButton
            .addTarget(
                self,
                action: #selector(captureButtonTapped),
                for: .touchUpInside
            )
        view.addSubview(captureButton)
        view.addSubview(flipButton)
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            flipButton.centerYAnchor.constraint(equalTo: captureButton.centerYAnchor),
            flipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60.ratio()),
            flipButton.widthAnchor.constraint(equalToConstant: 44.ratio()),
            flipButton.heightAnchor.constraint(equalToConstant: 44.ratio()),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16.ratio()),
            backButton.widthAnchor.constraint(equalToConstant: 44.ratio()),
            backButton.heightAnchor.constraint(equalToConstant: 44.ratio()),
        ])
        flipButton.isHidden = !canFlip
    }
    
    @objc private func captureButtonTapped() {
        capturePhoto()
    }
    
    @objc private func flipCamera() {
        captureSession.beginConfiguration()
        defer { captureSession.commitConfiguration() }
        guard let currentInput = captureSession.inputs.first as? AVCaptureDeviceInput,
              let newCamera = currentCamera?.position == .back ?
                AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) :
                AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
        else { return }
        do {
            let newInput = try AVCaptureDeviceInput(device: newCamera)
            captureSession.removeInput(currentInput)
            
            if captureSession.canAddInput(newInput) {
                captureSession.addInput(newInput)
                currentCamera = newCamera
            } else {
                captureSession.addInput(currentInput)
            }
        } catch {
            print("切换摄像头失败: \(error)")
        }
    }
    
    @objc func backEvent(){
        self.dismiss(animated: false)
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension BPImagePiakerViewController: @preconcurrency AVCapturePhotoCaptureDelegate {
     func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else { return }
         self.completion?(image);
    }
}
