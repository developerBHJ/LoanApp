//
//  View+Extension.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/12.
//

import UIKit

public extension UIView{
    
    @objc func configData(data: Any?){}
    
    func addSubView(view:UIView,edgeInsets: UIEdgeInsets){
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeInsets.left),
            view.topAnchor.constraint(equalTo: topAnchor, constant: edgeInsets.top),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: edgeInsets.right),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: edgeInsets.bottom),
        ])
    }
    
    func deactivateAll(){
        NSLayoutConstraint.deactivate(self.constraints)
    }
    
    func addSubView(view:UIView,leadingConstant: CGFloat? = nil,topConstant:CGFloat? = nil,trailingConstant:CGFloat? = nil,bottomConstant:CGFloat? = nil,centerYConstant: CGFloat? = nil,centerXConstant: CGFloat? = nil,width: CGFloat? = nil,height:CGFloat? = nil){
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        var constraints = [NSLayoutConstraint]()
        if let leadingConstant = leadingConstant{
            constraints.append(view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConstant))
        }
        if let trailingConstant = trailingConstant{
            constraints.append(view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConstant))
        }
        if let topConstant = topConstant{
            constraints.append(view.topAnchor.constraint(equalTo: topAnchor, constant: topConstant))
        }
        if let bottomConstant = bottomConstant{
            constraints.append(view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConstant))
        }
        if let centerYConstant = centerYConstant{
            constraints.append(view.centerYAnchor.constraint(equalTo: centerYAnchor, constant: centerYConstant))
        }
        if let centerXConstant = centerXConstant{
            constraints.append(view.centerXAnchor.constraint(equalTo: centerXAnchor, constant: centerXConstant))
        }
        if let width = width{
            constraints.append(view.widthAnchor.constraint(equalToConstant: width))
        }
        if let height = height{
            constraints.append(view.heightAnchor.constraint(equalToConstant: height))
        }
        if let bottomConstant = bottomConstant{
            constraints.append(view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConstant))
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat){
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    func addTarget(action: Selector?){
        self.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: action)
        self.addGestureRecognizer(tapGR)
    }
}
