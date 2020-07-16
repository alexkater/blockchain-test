//
//  FollowerAnimation.swift
//  BlockchainTest
//
//  Created by Alejandro Arjonilla Garcia on 07/07/2020.
//  Copyright © 2020 aarjincc. All rights reserved.
//

import UIKit

final class FollowerAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var duration: Double = 0.8
    var originFrame: CGRect = .zero
    var isPresenting = true

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animations: () -> Void

        if isPresenting {
            guard
                let toView = transitionContext.view(forKey: .to)
                else {
                    return
            }

            toView.frame = originFrame
            toView.alpha = isPresenting ? 0:1
            let containerView = transitionContext.containerView
            containerView.addSubview(toView)

            animations = {
                toView.frame.size = containerView.frame.size
                toView.center = containerView.center
                toView.alpha = 1
            }
        } else {

            guard
                let fromView = transitionContext.view(forKey: .from),
                let toView = transitionContext.view(forKey: .to)
                else {
                    return
            }

            let containerView = transitionContext.containerView
            containerView.insertSubview(toView, at: 0)

            animations = {
                fromView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                fromView.center = CGPoint(x: self.originFrame.midX, y: self.originFrame.midY)
            }
        }

        UIView.animate(
            withDuration: duration,
            delay:0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.2,
            animations: animations, completion: { _ in
                transitionContext.completeTransition(true)
        })
    }
}
