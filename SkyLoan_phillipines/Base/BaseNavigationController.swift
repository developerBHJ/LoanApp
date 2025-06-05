//
//  BaseNavigationController.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/13.
//

import UIKit
class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}
extension BaseNavigationController: UINavigationControllerDelegate{
    @objc func backToParentView(){
        if self.presentationController != nil && self.viewControllers.count == 1 {
            self.dismiss(animated: true, completion: nil);
        }else{
            let _ = self.popViewController(animated: true);
        }
    }
    
    open func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        if operation == UINavigationController.Operation.push{
            return getAnimationWithAnimationType(animationTyp: toVC.animationType,operation: operation);
        }else{
            return getAnimationWithAnimationType(animationTyp: fromVC.animationType,operation: operation);
        }
    }
}
