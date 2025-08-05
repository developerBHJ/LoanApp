//
//  TapLabel.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/13.
//

import UIKit
class TapLabel: UILabel {
    var model: Model = .init(){
        didSet{
            applyModel()
        }
    }
    
    init(frame: CGRect,model: Model) {
        super.init(frame: frame)
        self.model = model
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.isUserInteractionEnabled = true
        addGestureRecognizer(tapGR)
        applyModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyModel(){
        textColor = model.regularTextColor
        font = model.regularTextFont
        let attStr = NSMutableAttributedString(string: model.regluarText+model.linkText)
        attStr.addAttributes([
            NSAttributedString.Key.foregroundColor: model.linkTextColor,
            NSAttributedString.Key.font: model.linkTextFont,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ], range: .init(location: attStr.length - model.linkText.count, length: model.linkText.count))
        attributedText = attStr
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        let point = sender.location(in: self)
        let labelSize = self.bounds.size
        let textContainer = NSTextContainer(size: labelSize)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = self.lineBreakMode
        textContainer.maximumNumberOfLines = self.numberOfLines
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        let textStorage = NSTextStorage(attributedString: self.attributedText!)
        textStorage.addLayoutManager(layoutManager)
        let index = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        let attributedText = self.attributedText
        if (attributedText?.attribute(.underlineStyle, at: index, effectiveRange: nil)) != nil{
            print("点击了下划线部分")
            model.tapCompletion?(model.linkUrl)
        }
    }
}

extension TapLabel{
    struct Model {
        let linkTextColor: UIColor = kColor_black
        let linkTextFont: UIFont = SLFont(size: 11, weight: .semibold)
        let regularTextColor: UIColor = kColor_757575 ?? .white
        let regularTextFont: UIFont = SLFont(size: 11)
        var regluarText: String = ""
        var linkText: String = ""
        var linkUrl: String = ""
        var tapCompletion: ((String)-> Void)? = nil
    }
}
