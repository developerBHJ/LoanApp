//
//  BPAddressPickerView.swift
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

import UIKit

class BPAddressPickerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        applyModel()
    }
    
    init(frame: CGRect,model: BPAddressPickerViewModel = .init()) {
        self.model = model
        super.init(frame: frame)
        setupUI()
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc var model: BPAddressPickerViewModel = .init(){
        didSet{
            applyModel()
        }
    }
    
    var selectedButton: UIButton?
    var indicatorCenterXConstraint: NSLayoutConstraint?
    
    lazy var pickerView : UIPickerView = {
        let view = UIPickerView.init(
            frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 200.ratio())
        )
        view.backgroundColor = UIColor.clear
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var firstButton : UIButton = {
        let view = UIButton(type: .custom)
        view.backgroundColor = UIColor.clear
        view.setTitle("Street", for: .normal)
        view.setTitleColor(.gray, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        view
            .addTarget(
                self,
                action: #selector(segementEvent(sender:)),
                for: .touchUpInside
            )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 1000;
        return view
    }()
    
    lazy var secondButton : UIButton = {
        let view = UIButton(type: .custom)
        view.backgroundColor = UIColor.clear
        view.setTitle("Town", for: .normal)
        view.setTitleColor(.gray, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        view
            .addTarget(
                self,
                action: #selector(segementEvent(sender:)),
                for: .touchUpInside
            )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 1001;
        return view
    }()
    
    lazy var thirdButton : UIButton = {
        let view = UIButton(type: .custom)
        view.backgroundColor = UIColor.clear
        view.setTitle("State", for: .normal)
        view.setTitleColor(.gray, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        view
            .addTarget(
                self,
                action: #selector(segementEvent(sender:)),
                for: .touchUpInside
            )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = 1002;
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var selectedType: Int = 0
    private var selectedProvince: BPAddressModel?
    private var selectedCity: BPAddressModel?
    private var selectedStreet: BPAddressModel?
}

extension BPAddressPickerView: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if selectedType == 0{
            return model.dataSource.count
        }else if selectedType == 1{
            return selectedProvince?.andwalked.count ?? 0
        }else{
            return selectedCity?.andwalked.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.ratio()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title: String?
        if selectedType == 0{
            title = model.dataSource[row].tongues
        }else if selectedType == 1,selectedProvince?.andwalked.count ?? 0 > row{
            title = selectedProvince?.andwalked[row].tongues
        }else if selectedCity?.andwalked.count ?? 0 > row{
            title = selectedCity?.andwalked[row].tongues
        }
        return title
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        if selectedType == 0,model.dataSource.count > row{
            selectedProvince = model.dataSource[row]
            let address = selectedProvince?.tongues ?? ""
            model.valueChanged?(address)
            model.completed?(false)
        }else if selectedType == 1,selectedProvince?.andwalked.count ?? 0 > row{
            selectedCity = selectedProvince?.andwalked[row]
            let address = (selectedProvince?.tongues ?? "")  + "-" + (
                selectedCity?.tongues ?? ""
            )
            model.valueChanged?(address)
            model.completed?(false)
        }else if selectedCity?.andwalked.count ?? 0 > row{
            selectedStreet = selectedCity?.andwalked[row]
            let provice = (selectedProvince?.tongues ?? "")
            let cityName = (selectedCity?.tongues ?? "")
            let street = (selectedStreet?.tongues ?? "")
            let address = provice + "-" + cityName + "-" + street
            model.valueChanged?(address)
            model.completed?(true)
        }
    }
}

extension BPAddressPickerView{
    func setupUI(){
        backgroundColor = .clear
        addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.topAnchor
                .constraint(equalTo: topAnchor,constant: 44.ratio()),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 436.ratio()),
        ])
        addSubview(firstButton)
        addSubview(secondButton)
        addSubview(thirdButton)
        addSubview(lineView)
        self.indicatorCenterXConstraint = lineView.centerXAnchor
            .constraint(equalTo: firstButton.centerXAnchor)
        let buttonWidth = (kScreenW - 44.ratio()) / 3
        if let indiactorConstraint = self.indicatorCenterXConstraint {
            NSLayoutConstraint.activate(
                [
                    firstButton.leadingAnchor
                        .constraint(
                            equalTo: leadingAnchor,
                            constant: 22.ratio()
                        ),
                    firstButton.topAnchor.constraint(equalTo: topAnchor),
                    firstButton.heightAnchor
                        .constraint(equalToConstant: 44.ratio()),
                    firstButton.widthAnchor
                        .constraint(equalToConstant: buttonWidth),
                    
                    secondButton.centerXAnchor
                        .constraint(equalTo: centerXAnchor),
                    secondButton.topAnchor.constraint(equalTo: topAnchor),
                    secondButton.heightAnchor
                        .constraint(equalToConstant: 44.ratio()),
                    secondButton.widthAnchor
                        .constraint(equalToConstant: buttonWidth),

                    thirdButton.trailingAnchor
                        .constraint(
                            equalTo: trailingAnchor,
                            constant: -22.ratio()
                        ),
                    thirdButton.topAnchor.constraint(equalTo: topAnchor),
                    thirdButton.heightAnchor
                        .constraint(equalToConstant: 44.ratio()),
                    thirdButton.widthAnchor
                        .constraint(equalToConstant: buttonWidth),
                
                    indiactorConstraint,
                    lineView.topAnchor
                        .constraint(
                            equalTo: firstButton.bottomAnchor,
                            constant: -5.ratio()
                        ),
                    lineView.heightAnchor
                        .constraint(equalToConstant: 3.ratio()),
                    lineView.widthAnchor
                        .constraint(equalToConstant: 32.ratio()),
                ]
            )
        }
    }
    
    func applyModel(){
        pickerView.reloadAllComponents()
        self.segementEvent(sender: firstButton)
    }
    
    @objc func segementEvent(sender: UIButton) -> Void{
        sender.setTitleColor(.black, for: .normal);
        self.selectedButton?.setTitleColor(.gray, for: .normal)
        self.selectedButton = sender
        self.indicatorCenterXConstraint?.isActive = false
        self.indicatorCenterXConstraint =  lineView.centerXAnchor
            .constraint(equalTo: sender.centerXAnchor)
        self.indicatorCenterXConstraint?.isActive = true
        let tag = sender.tag - 1000
        self.selectedType = tag;
        self.pickerView.reloadComponent(0)
        self.pickerView(pickerView, didSelectRow: 0, inComponent: 0);
        setNeedsLayout()
    }
    
    @objc func nextStep() -> Void{
        if ((self.selectedProvince != nil) && (self.selectedCity == nil)) {
            self.segementEvent(sender: secondButton)
        }else if((self.selectedProvince != nil) && (self.selectedCity != nil)){
            self.segementEvent(sender: thirdButton)
        }
    }
}

@objc
extension BPAddressPickerView{
    @MainActor
    @objc class BPAddressPickerViewModel: NSObject {
        @objc var contentHeight = 200.ratio()
        @objc var dataSource: [BPAddressModel] = []
        @objc var valueChanged: ((String)-> Void)? = nil
        @objc var completed: ((Bool)-> Void)? = nil
    }
}
