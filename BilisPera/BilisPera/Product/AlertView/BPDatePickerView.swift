//
//  BPDatePickerView.swift
//  BilisPera
//
//  Created by BHJ on 2025/8/19.
//

import UIKit

class BPDatePickerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        applyModel()
    }
    
    init(frame: CGRect,model: BPDatePickerViewModel = .init()) {
        self.model = model
        super.init(frame: frame)
        setupUI()
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc var model: BPDatePickerViewModel = .init(){
        didSet{
            applyModel()
        }
    }
    
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
    
    lazy var firstLabel : UILabel = {
        let view = UILabel.init()
        view.backgroundColor = UIColor.clear
        view.textColor = UIColor.black
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = "Day"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var secondLabel : UILabel = {
        let view = UILabel.init()
        view.backgroundColor = UIColor.clear
        view.textColor = UIColor.black
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = "Month"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var thirdLabel : UILabel = {
        let view = UILabel.init()
        view.backgroundColor = UIColor.clear
        view.textColor = UIColor.black
        view.font = UIFont.systemFont(ofSize: 16)
        view.text = "Year"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var currentDateCom: DateComponents = Calendar.current.dateComponents(
        [.year, .month, .day],
        from: Date()
    )    //日期类型
    private var selectedYear: Int = 0
    private var selectedMonth: Int = 0
    private var selectedDay: Int = 0
    private var selectedComponent: Int = 0
    private var months: [Int] = Array(1...12)
    private var days: [Int] = Array(1...31)
}

extension BPDatePickerView: UIPickerViewDelegate,UIPickerViewDataSource{
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
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        selectedComponent = component
        selectedYear = (self.currentDateCom.year!) - self.pickerView
            .selectedRow(inComponent: 2)
        selectedMonth = self.pickerView.selectedRow(inComponent: 1) + 1
        selectedDay = self.pickerView.selectedRow(inComponent: 0) + 1
        let dateString = String(
            format: "%02ld-%02ld-%02ld",
            selectedDay,
            selectedMonth,
            selectedYear
        )
        model.valueChanged?(dateString)
        if component == 2 {
            let year: Int = pickerView.selectedRow(
                inComponent: 2
            ) + currentDateCom.year!
            let currentMonth = Date().currentMonth
            let currentYear = Date().currentYear
            if year == currentYear{
                months = Array(1...currentMonth)
            }
            pickerView.reloadComponent(1)
        }
        if component == 1 {
            let year: Int = pickerView.selectedRow(
                inComponent: 2
            ) + currentDateCom.year!
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

extension BPDatePickerView{
    func setupUI(){
        backgroundColor = .clear
        addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerView.topAnchor.constraint(equalTo: topAnchor,constant: 44.ratio()),
            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 436.ratio()),
        ])
        addSubview(stackView)
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(thirdLabel)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 44.ratio())
        ])
    }
    
    func applyModel(){
        self.pickerView.reloadAllComponents()
       let currentDate = Date.stringToDate(self.model.currentDate,dateFormat: "dd-MM-yyyy") ?? Date()
        let dateCom = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: currentDate
        )
        let currentYear = dateCom.year ?? 0
        let currentMonths = dateCom.month ?? 0
        let currentDay = dateCom.day ?? 0
        let currentYearIndex = currentDateCom.year! - currentYear
        self.pickerView
            .selectRow(currentYearIndex, inComponent: 2, animated: true)
        self.pickerView
            .selectRow(currentMonths - 1, inComponent: 1, animated: true)
        self.pickerView
            .selectRow(currentDay - 1, inComponent: 0, animated: true)
        self.pickerView(pickerView, didSelectRow: currentDay - 1, inComponent: 0)
        self.pickerView(pickerView, didSelectRow: currentMonths - 1, inComponent: 1)
        self.pickerView(pickerView, didSelectRow: currentYearIndex, inComponent: 2)
    }
    
    private func howManyDays(inThisYear year: Int, withMonth month: Int) -> Int {
        let daysInMonth = Date.daysInMonth(year: year, month: month)
        return daysInMonth
    }
}

@objc
extension BPDatePickerView{
    @MainActor
    @objc class BPDatePickerViewModel: NSObject {
       @objc var contentHeight = 436.ratio()
      @objc  var currentDate: String = ""
       @objc var valueChanged: ((String)-> Void)? = nil
    }
}
