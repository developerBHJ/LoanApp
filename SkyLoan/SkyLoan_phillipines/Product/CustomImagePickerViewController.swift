//
//  CustomImagePickerViewController.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/26.
//
import UIKit
import AVFoundation

protocol CustomCameraViewDelegate{
    func didFinishPickingImage(image: UIImage)
}

class CustomCameraViewController: UIViewController {
    
    // MARK: - 属性
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var currentCamera: AVCaptureDevice!
    private var photoOutput: AVCapturePhotoOutput!
    
    // MARK: - UI组件
    private let captureButton = UIButton()
    private let flashButton = UIButton()
    private var position: AVCaptureDevice.Position = .back
    
    lazy var navBar: CustomNavigationBar = {
        let view = CustomNavigationBar(frame: .init(x: 0, y: 0, width: kScreenW, height: kNavigationBarH))
        view.backButton.setImage(UIImage(named: "icon_back")?.withTintColor(.white,renderingMode: .alwaysOriginal), for: .normal)
        return view
    }()
    
    var delegate: CustomCameraViewDelegate?
    
    convenience init(position: AVCaptureDevice.Position){
        self.init()
        self.position = position
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCamera()
    }
    
    // MARK: - 相机配置
    private func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: self.position) else { return }
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
            DispatchQueue.global().async(execute: {[weak self] in
                self?.captureSession.startRunning()
            })
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
        captureButton.frame = CGRect(x: view.center.x - 35, y: view.bounds.height - 100, width: 70, height: 70)
        captureButton.backgroundColor = .white
        captureButton.layer.cornerRadius = 35
        captureButton.addTarget(self, action: #selector(captureButtonTapped), for: .touchUpInside)
        view.addSubview(captureButton)
        view.addSubview(navBar)
    }
    
    @objc private func captureButtonTapped() {
        capturePhoto()
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension CustomCameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else { return }
        delegate?.didFinishPickingImage(image: image)
    }
}
