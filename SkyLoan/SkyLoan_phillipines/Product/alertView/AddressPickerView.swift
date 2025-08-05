//
//  AddressPickerView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/28.
//

import UIKit

class AddressPickerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        applyModel()
    }
    
    init(frame: CGRect,model: Model = .init()) {
        super.init(frame: frame)
        self.model = model
        setupUI()
        applyModel()
        self.pickerView(self.pickerView, didSelectRow: 0, inComponent: 0)
        pickerView.selectRow(0, inComponent: 0, animated: false)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
    
    lazy var pickerView : UIPickerView = {
        let view = UIPickerView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 200.ratio()))
        view.backgroundColor = UIColor.clear
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    lazy var headerView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 0
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(kColor_black, for: .normal)
        button.titleLabel?.font = SLFont(size: 13, weight: .medium)
        button.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
        button.setTitle("Choose", for: .normal)
        button.tag = 1000
        return button
    }()
    
    lazy var middleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(kColor_black, for: .normal)
        button.titleLabel?.font = SLFont(size: 13, weight: .medium)
        button.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
        button.setTitle("Choose", for: .normal)
        button.tag = 1001
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(kColor_black, for: .normal)
        button.titleLabel?.font = SLFont(size: 13, weight: .medium)
        button.addTarget(self, action: #selector(buttonEvent(sender:)), for: .touchUpInside)
        button.setTitle("Choose", for: .normal)
        button.tag = 1002
        return button
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = kColor_black
        return view
    }()
    
    lazy var topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = kColor_black
        return view
    }()
    
    lazy var bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = kColor_black
        return view
    }()
    
    private var selectedType: Int = 0
    private var selectedProvince: AddressModel?
    private var selectedCity: AddressModel?
    private var selectedStreet: AddressModel?
}

extension AddressPickerView: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if selectedType == 0{
            return model.dataSource.count
        }else if selectedType == 1{
            return selectedProvince?.trust.count ?? 0
        }else{
            return selectedCity?.trust.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 33.ratio()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var title: String?
        if selectedType == 0{
            title = model.dataSource[row].nowadays
        }else if selectedType == 1,selectedProvince?.trust.count ?? 0 > row{
            title = selectedProvince?.trust[row].nowadays
        }else if selectedCity?.trust.count ?? 0 > row{
            title = selectedCity?.trust[row].nowadays
        }
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectedType == 0,model.dataSource.count > row{
            selectedProvince = model.dataSource[row]
            leftButton.setTitle(selectedProvince?.nowadays, for: .normal)
            let address = selectedProvince?.nowadays ?? ""
            model.valueChanged?(address,false)
        }else if selectedType == 1,selectedProvince?.trust.count ?? 0 > row{
            selectedCity = selectedProvince?.trust[row]
            middleButton.setTitle(selectedCity?.nowadays, for: .normal)
            let address = (selectedProvince?.nowadays ?? "")  + " " + (selectedCity?.nowadays ?? "")
            model.valueChanged?(address,false)
        }else if selectedCity?.trust.count ?? 0 > row{
            selectedStreet = selectedCity?.trust[row]
            rightButton.setTitle(selectedStreet?.nowadays, for: .normal)
            let address = (selectedProvince?.nowadays ?? "") + "-" + (selectedCity?.nowadays ?? "") + "-" +  (selectedStreet?.nowadays ?? "")
            model.valueChanged?(address,true)
        }
    }
}

extension AddressPickerView{
    func setupUI(){
        backgroundColor = .clear
        addSubview(headerView)
        headerView.addSubViews(views: [leftButton,middleButton,rightButton])
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(30.ratio())
            make.height.equalTo(20.ratio())
        }
        addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(10.ratio())
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1.ratio())
        }
        addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0)
            make.bottom.equalToSuperview()
        }
        addSubview(topLineView)
        topLineView.snp.makeConstraints { make in
            make.bottom.equalTo(pickerView.snp.centerY).offset(-16.ratio())
            make.height.equalTo(1.ratio())
            make.leading.trailing.equalToSuperview().inset(46.ratio())
        }
        addSubview(bottomLineView)
        bottomLineView.snp.makeConstraints { make in
            make.top.equalTo(pickerView.snp.centerY).offset(16.ratio())
            make.height.equalTo(1.ratio())
            make.leading.trailing.equalToSuperview().inset(46.ratio())
        }
    }
    
    func applyModel(){
        pickerView.snp.updateConstraints { make in
            make.height.equalTo(model.contentHeight)
        }
    }
    
    @objc func buttonEvent(sender: UIButton){
        self.selectedType = sender.tag - 1000
        self.pickerView.reloadComponent(0)
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
        self.pickerView(self.pickerView, didSelectRow: 0, inComponent: 0)
    }
}

extension AddressPickerView{
    struct Model {
        var contentHeight = 200.ratio()
        var dataSource: [AddressModel] = LoginTool.shared.addressList
        var valueChanged: ((String,Bool)-> Void)? = nil
    }
}

