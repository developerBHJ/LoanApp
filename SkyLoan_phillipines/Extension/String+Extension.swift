//
//  String+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/14.
//

import Foundation
import UIKit

extension String{
    func safePhoneNumber(_ lg : Int = 4) -> String {
        if self.count < lg + 3 {
            return ""
        }
        let str = NSString.init(string: self)
        let seSting = "***********"
        let phone = str.replacingCharacters(in: NSRange.init(location: 3, length: lg), with: String(seSting.suffix(lg))) as String
        return phone
    }
    
    func addUnderline() -> NSAttributedString?{
        guard self.count > 0 else {return nil}
        let attStr = NSMutableAttributedString(string: self)
        attStr.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,NSAttributedString.Key.baselineOffset: 6.ratio()], range: .init(location: 0, length: self.count))
        return attStr
    }
    
    func toInt()-> Int?{
        Int(self)
    }
    
    func toDictionary()-> [String: Any]?{
        guard let data = self.data(using: .utf8) else {return nil}
        do{
            if let dic = try JSONSerialization.jsonObject(with: data,options: []) as? [String: Any]{
                return dic
            }
        }catch{
            return nil
        }
        return nil
    }
    
    func getWidth(font: UIFont,height: CGFloat = CGFLOAT_MAX) -> CGFloat{
        guard !self.isEmpty else {return 0}
        let label = UILabel()
        label.frame = .init(x: 0, y: 0, width: CGFLOAT_MAX, height: height)
        label.font = font
        let attStr = NSAttributedString(string: self,attributes: [NSAttributedString.Key.font:font])
        label.attributedText = attStr
        label.sizeToFit()
        return label.frame.size.width
    }
    
    func getHtmlUrl() -> URL?{
        var path = self
        if !self.contains("?") {
            path = self + "?" + PublicParamas().toURLStrings()
        }else{
            path = self + PublicParamas().toURLStrings()
        }
        if let encodedURL = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),let url = URL(string: encodedURL){
            return url
        }
        return nil
    }
}
