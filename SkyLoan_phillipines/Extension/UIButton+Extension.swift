//
//  UIButton+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/15.
//

import UIKit
enum ImagePositionType: Int{
    case left //图片在左,标题在右,默认
    case right // 图片在右,标题在左
    case top //图片在上,标题在下
    case bottom //图片在下,标题在上
}

extension UIButton{
    private static var hitEdgeInsetsKey = "hitEdgeInsetsKey";
    
    var hitEdgeInsets: UIEdgeInsets{
        set {
            objc_setAssociatedObject(self,  &UIButton.hitEdgeInsetsKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        get {
            if objc_getAssociatedObject(self, &UIButton.hitEdgeInsetsKey) is UIEdgeInsets {
                return (objc_getAssociatedObject(self, &UIButton.hitEdgeInsetsKey) as? UIEdgeInsets)!;
            }
            return UIEdgeInsets.zero;
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let newRect: CGRect = self.bounds.inset(by: hitEdgeInsets)
        return newRect.contains(point)
    }
}

extension UIButton{
    
    func layoutImagePositionType(type: ImagePositionType, spacing:CGFloat = 2) -> () {
        guard let text = titleLabel?.text, let imageSize = image(for: .normal)?.size else {
            return
        }
        let titleSize = (text as NSString).size(withAttributes: [NSAttributedString.Key.font:  titleLabel?.font ?? UIFont.systemFont(ofSize: 15)])
        switch type {
        case .left:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
            break
        case .right:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: 0, right: imageSize.width + spacing)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width + spacing, bottom: 0, right: -titleSize.width)
            break
        case .top:
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
            imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
            break
        default:
            titleEdgeInsets = UIEdgeInsets(top: -(imageSize.height + spacing), left: -imageSize.width, bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -(titleSize.height + spacing), right: -titleSize.width)
            break
        }
    }
}
