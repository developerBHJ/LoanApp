//
//  CustomPushAnimator.swift
//  SkyLoan_phillipines
//
//  Created by BHJ on 2025/5/15.
//

import UIKit

public enum UIViewControllerAnimationType:Int {
    case noneAnimation
    case rlScanAnimation
}

func getAnimationWithAnimationType(animationTyp:UIViewControllerAnimationType,operation:UINavigationController.Operation)-> UIViewControllerAnimatedTransitioning?{
    
    switch animationTyp {
    case .rlScanAnimation:
        let animation = RoundAnimation.init();
        animation.animationDirection = .rightLeft;
        animation.transitionType = operation;
        return animation;
    case .noneAnimation:
        return nil;
    }
}

class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        let containerView = transitionContext.containerView
        let finalFrameForToVC = transitionContext.finalFrame(for: toVC)
        toVC.view.frame = CGRect(origin: CGPoint(x: containerView.bounds.width, y: 0), size: finalFrameForToVC.size)
        containerView.addSubview(toVC.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromVC.view.transform = CGAffineTransform(translationX: -containerView.bounds.width, y: 0)
            toVC.view.transform = .identity
        }, completion: { finished in
            fromVC.view.transform = .identity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}


