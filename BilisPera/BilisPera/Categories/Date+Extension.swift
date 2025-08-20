//
//  Date+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/27.
//

import Foundation

extension Date{
    /// 当前是哪一年
    var currentYear : Int{
        let currentDate = Date()
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.year], from: currentDate)
        return dateComponent.year ?? 0
    }
    
    /// 当前月份
    var currentMonth : Int{
        let currentDate = Date()
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.month], from: currentDate)
        return dateComponent.month ?? 1
    }
    
    /// 当前哪一天
    var currentDay : Int{
        let currentDate = Date()
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.day], from: currentDate)
        return dateComponent.day ?? 1
    }
    /// 当前时间字符串
    /// - Parameter formatter: 时间格式
    /// - Returns: 时间字符串
    static func currentTime(_ formatter:String = "YYYY-MM-dd HH:mm:ss") -> String {
        let currentDate = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = formatter// 自定义时间格式
        return dateformatter.string(from: currentDate)
    }
         
   static func daysInMonth(year: Int, month: Int) -> Int {
        // 创建一个日历
        let calendar = Calendar.current
        // 创建一个表示指定日期的日期组件
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        // 使用日历的组件方法来获取该月的天数
        if let date = calendar.date(from: dateComponents) {
            let range = calendar.range(of: .day, in: .month, for: date)!
            return range.count
        } else {
            return 0 // 如果日期创建失败，返回0，通常不应该发生，除非年份或月份不合法
        }
    }
    
    static func stringToDate(_ time: String,dateFormat: String = "YYYY-MM-dd HH:mm:ss") -> Date? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = dateFormat
        dateformatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateformatter.date(from: time)
        return date
    }
}
