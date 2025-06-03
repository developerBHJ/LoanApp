//
//  UILabel+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/21.
//

import UIKit
extension UILabel {
    func setLineHeight(_ lineHeight: CGFloat) {
        guard let text = self.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - font.lineHeight
        paragraphStyle.alignment = textAlignment
        attributedString.addAttributes([
            .paragraphStyle: paragraphStyle,
            .font: font ?? UIFont.systemFont(ofSize: 14)
        ], range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedString
    }
}
