//
//  LoginViewController.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/12.
//
import UIKit
import Combine

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        setupUI()
        updateUI(isEnabled: false)
        viewModel.loginEnabled.sink {[weak self] selected in
            self?.updateUI(isEnabled: selected)
        }.store(in: &cancellables)
        ADTool.shared.registerIDFAAndTrack()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hiddenNavigationBar = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard contentView.frame.height > 0 else {return}
        contentView.roundCorners([.topLeft], radius: Constant.contentTopCorner)
    }
    
    var completion: (()-> Void)? = nil
    private var cancellables = Set<AnyCancellable>()
    
    lazy var bgImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var logoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var titleView: UILabel = {
        let view = UILabel()
        view.textColor = kColor_FFF20E
        view.font = SLFont(size: 20,weight: .black)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var phoneView: InputView = {
        let view = InputView()
        view.model = .init(title: Constant.phoneViewTitle,text:LoginTool.shared.getUserName(),placeHolder: Constant.codeViewPlaceHolder,needLeftView: true,valueChanged: {[weak self] value in
            self?.viewModel.phone = value
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var codeView: InputView = {
        let view = InputView()
        view.model = .init(title: Constant.codeViewTitle,placeHolder: Constant.codeViewPlaceHolder,valueChanged: {[weak self] value in
            self?.viewModel.code = value
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 25.ratio()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var sendButton: CutDownButton = {
        let view = CutDownButton(type: .custom)
        view.setTitleColor(kColor_FF8370, for: .normal)
        view.titleLabel?.font = SLFont(size: 15, weight: .black)
        view.model = .init(title: Constant.sendButtonTitle)
        view.addTarget(self, action: #selector(sendCode), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var privacyView: PrivacyView = {
        let view = PrivacyView(frame: .zero)
        view.model = .init(normalStr: Constant.privacyPre,linkStr: Constant.privacyTap,linkUrl: Constant.privacyLinkUrl,checkBoxCompletion: {[weak self] selected in
            self?.viewModel.isSelected = selected
            self?.view.endEditing(true)
        },tapLinkCompletion: {[weak self] linkurl in
            self?.onPushPrivacyView(url: linkurl)
        })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "icon_login_login"), for: .normal)
        button.addTarget(self, action: #selector(loginEvent), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var viewModel: LoginViewModel = LoginViewModel()
}

extension LoginViewController: BaseViewController{
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
    
    func setupUI(){
        bgImageView.image = UIImage(named: "icon_login_bg")
        view.addSubView(view: bgImageView, edgeInsets: UIEdgeInsets.zero)
        view.addSubView(view: contentView, edgeInsets: UIEdgeInsets.init(top: Constant.contentTop, left: 0, bottom: 0, right: 0))
        logoView.image = UIImage(named: "icon_logo_35")
        view.addSubView(view: logoView, leadingConstant: 32.ratio(),topConstant: kStatusBarH + 21.ratio(),width: 35.ratio(),height: 35.ratio())
        view.addSubview(titleView)
        titleView.text = Constant.title
        view.addSubview(stackView)
        view.addSubview(sendButton)
        view.addSubview(privacyView)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: logoView.trailingAnchor, constant: 10.ratio()),
            titleView.centerYAnchor.constraint(equalTo: logoView.centerYAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 34.ratio()),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50.5.ratio()),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50.5.ratio()),
            
            sendButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16.ratio()),
            sendButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            sendButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 52.ratio()),
            sendButton.heightAnchor.constraint(equalToConstant: 22.ratio()),
            
            privacyView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 92.ratio()),
            privacyView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            privacyView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10.ratio()),
            
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10.ratio()),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: Constant.loginButtonLeftSpace),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -Constant.loginButtonLeftSpace),
            loginButton.heightAnchor.constraint(equalToConstant: Constant.loginButtonHeight)
        ])
        stackView.addArrangedSubview(phoneView)
        stackView.addArrangedSubview(codeView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func sendCode(){
        self.view.endEditing(true)
//        sendButton.startCountdown {}
        viewModel.getVerifyCode()
        TrackMananger.shared.startTime = CFAbsoluteTimeGetCurrent()
        guard ADTool.shared.trackCount < 2 else {return}
        TrackMananger.shared.trackGoogleMarket()
        ADTool.shared.trackCount += 1
    }
    
    @objc func loginEvent(){
        Task{
            let _ = await viewModel.login()
            TrackMananger.shared.endTime = CFAbsoluteTimeGetCurrent()
            completion?()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateUI(isEnabled: Bool = false){
        loginButton.isEnabled = isEnabled
    }
    
    func onPushPrivacyView(url: String){
        RouteManager.shared.routeTo(HtmlPath.privacy.url)
    }
}
