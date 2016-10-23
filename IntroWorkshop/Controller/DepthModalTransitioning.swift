//
//  DepthModalTransitioning.swift
//  IntroWorkshop
//
//  Created by Ken Ko on 23/10/2016.
//  Copyright © 2016 Commonwealth Bank of Australia. All rights reserved.
//

import Foundation

class DepthModalTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    static let sharedInstance = DepthModalTransitioningDelegate()

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DepthModalTransition(present: true)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DepthModalTransition(present: false)
    }
}

class DepthModalTransition: NSObject, UIViewControllerAnimatedTransitioning {

    struct Constants {
        static let animationDuration: TimeInterval = 0.3
        static let scaleFactor: CGFloat = 0.95
        static let fadeOutOpacity: CGFloat = 0.4
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.animationDuration
    }

    let present: Bool

    init(present: Bool) {
        self.present = present
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let completion = {
            transitionContext.completeTransition(true)
        }
        if present {
            animatePresentation(containerView: containerView, fromView: fromView, toView: toView, completion: completion)
        } else {
            animateDismissal(containerView: containerView, fromView: fromView, toView: toView, completion: completion)
        }
    }

    func animatePresentation(containerView: UIView?, fromView: UIView?, toView: UIView?, completion: @escaping () -> Void) {
        guard let containerView = containerView,
            let fromView = fromView,
            let toView = toView else {
            completion()
            return
        }

        let originalToFrame = toView.frame
        var toFrame = toView.frame
        toFrame.origin.y = containerView.frame.height
        toView.frame = toFrame
        containerView.addSubview(toView)

        UIView.animate(withDuration: Constants.animationDuration, animations: {
            toView.frame = originalToFrame

            fromView.transform = CGAffineTransform(scaleX: Constants.scaleFactor, y: Constants.scaleFactor)
            fromView.alpha = Constants.fadeOutOpacity
        }) { _ in
            completion()
        }
    }


    func animateDismissal(containerView: UIView?, fromView: UIView?, toView: UIView?, completion: @escaping () -> Void) {
        guard let containerView = containerView,
            let fromView = fromView,
            let toView = toView else {
            completion()
            return
        }

        containerView.insertSubview(toView, belowSubview: fromView)

        var fromFrame = fromView.frame
        fromFrame.origin.y = containerView.frame.height

        UIView.animate(withDuration: Constants.animationDuration, animations: {
            fromView.frame = fromFrame

            toView.transform = CGAffineTransform.identity
            toView.alpha = 1.0
        }) { _ in
            completion()
        }
    }


}
