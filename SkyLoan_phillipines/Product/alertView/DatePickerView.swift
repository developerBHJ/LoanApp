//
//  DatePickerView.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/26.
//

import UIKit

class DatePickerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        applyModel()
    }
    
    init(frame: CGRect,model: Model = .init()) {
        self.model = model
        super.init(frame: frame)
        setupUI()
        applyModel()
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
    
    lazy var borderView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_date_border")
        return view
    }()
    
    private var currentDateCom: DateComponents = Calendar.current.dateComponents([.year, .month, .day],   from: Date())    //日期类型
    private var selectedYear: Int = 0
    private var selectedMonth: Int = 0
    private var selectedDay: Int = 0
    private var selectedComponent: Int = 0
    private var months: [Int] = Array(1...12)
    private var days: [Int] = Array(1...31)
}

extension DatePickerView: UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 2 {
            return 100
        } else if component == 1 {
            return months.count
        } else {
            return days.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 33.ratio()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 2 {
            return "\((currentDateCom.year!) - row)"
        } else if component == 1 {
            return "\(row + 1)"
        } else {
            return "\(row + 1)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedComponent = component
        selectedYear = (self.currentDateCom.year!) - self.pickerView.selectedRow(inComponent: 2)
        selectedMonth = self.pickerView.selectedRow(inComponent: 1) + 1
        selectedDay = self.pickerView.selectedRow(inComponent: 0) + 1
        let dateString = String(format: "%02ld-%02ld-%02ld", selectedYear, selectedMonth, selectedDay)
        model.valueChanged?(dateString)
        if component == 2 {
            let year: Int = pickerView.selectedRow(inComponent: 2) + currentDateCom.year!
            let currentMonth = Date().currentMonth
            let currentYear = Date().currentYear
            if year == currentYear{
                months = Array(1...currentMonth)
            }
            pickerView.reloadComponent(1)
        }
        if component == 1 {
            let year: Int = pickerView.selectedRow(inComponent: 2) + currentDateCom.year!
            let month: Int = pickerView.selectedRow(inComponent: 1) + 1
            let days: Int = howManyDays(inThisYear: year, withMonth: month)
            let currentMoth = Date().currentMonth
            let currentYear = Date().currentYear
            let currentDay = Date().currentDay
            if year == currentYear,
               month == currentMoth{
                self.days = Array(1 ... currentDay)
            }else{
                self.days = Array(1 ... days)
            }
            pickerView.reloadComponent(0)
        }
    }
}

extension DatePickerView{
    func setupUI(){
        backgroundColor = .clear
        addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12.ratio())
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0)
            make.bottom.equalToSuperview()
        }
        addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.centerY.equalTo(pickerView)
            make.height.equalTo(35.ratio())
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func applyModel(){
        pickerView.snp.updateConstraints { make in
            make.height.equalTo(model.contentHeight)
        }
        self.pickerView.reloadAllComponents()
        let dateCom = Calendar.current.dateComponents([.year, .month, .day],   from: self.model.currentDate)
        let currentYear = dateCom.year ?? 0
        let currentMonths = dateCom.month ?? 0
        let currentDay = dateCom.day ?? 0
        let currentYearIndex = currentDateCom.year! - currentYear
        self.pickerView.selectRow(currentYearIndex, inComponent: 2, animated: true)
        self.pickerView.selectRow(currentMonths - 1, inComponent: 1, animated: true)
        self.pickerView.selectRow(currentDay - 1, inComponent: 0, animated: true)
    }
    
    private func howManyDays(inThisYear year: Int, withMonth month: Int) -> Int {
        let daysInMonth = Date.daysInMonth(year: year, month: month)
        return daysInMonth
    }
}

extension DatePickerView{
    struct Model {
        var contentHeight = 200.ratio()
        var currentDate: Date = Date()
        var valueChanged: ((String)-> Void)? = nil
    }
}
