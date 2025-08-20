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
    
    private lazy var flipButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "camera.rotate"), for: .normal)
        button.addTarget(self, action: #selector(flipCamera), for: .touchUpInside)
        button.tintColor = UIColor.white
        return button
    }()
    
    lazy var navBar: CustomNavigationBar = {
        let view = CustomNavigationBar(frame: .init(x: 0, y: 0, width: kScreenW, height: kNavigationBarH))
        view.backButton.setImage(UIImage(named: "icon_back")?.withTintColor(.white,renderingMode: .alwaysOriginal), for: .normal)
        return view
    }()
    
    var delegate: CustomCameraViewDelegate?
    var canFlip: Bool = false
    
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
        view.backgroundColor = .black
        // 拍照按钮配置
        captureButton.frame = CGRect(x: view.center.x - 35.ratio(), y: view.bounds.height - 100.ratio(), width: 70.ratio(), height: 70.ratio())
        captureButton.backgroundColor = .white
        captureButton.layer.cornerRadius = 35.ratio()
        captureButton.addTarget(self, action: #selector(captureButtonTapped), for: .touchUpInside)
        view.addSubview(captureButton)
        view.addSubview(navBar)
        view.addSubview(flipButton)
        flipButton.snp.makeConstraints { make in
            make.centerY.equalTo(captureButton.snp.centerY)
            make.trailing.equalToSuperview().inset(60.ratio())
            make.width.height.equalTo(44.ratio())
        }
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
}

// MARK: - AVCapturePhotoCaptureDelegate
extension CustomCameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else { return }
        let preview = PreviewViewController(image: image) {[weak self] image in
            self?.delegate?.didFinishPickingImage(image: image)
        }
        preview.presentFullScreenAndDisablePullToDismiss()
        present(preview, animated: true)
    }
}
