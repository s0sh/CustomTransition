//
//  PresentAnimation.swift
//  TransitionController
//
//  Created by Roman Bigun on 11.08.2022.
//

import UIKit

enum TransitionPosition {
    case full
    case half
    case middle
}

class PresentAnimation: NSObject {
    
    var duration: TimeInterval = 0.3
    let position: TransitionPosition
    
    init(duration: Double, position: TransitionPosition) {
        self.duration = duration
        self.position = position
    }
    
    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // transitionContext.view содержит всю нужную информацию, извлекаем её
        let to = transitionContext.view(forKey: .to)!
        let finalFrame = transitionContext.finalFrame(for: transitionContext.viewController(forKey: .to)!) // Тот самый фрейм, который мы задали в PresentationController
        // Смещаем контроллер за границу экрана
        switch position {
        case .full:
            to.frame = finalFrame
        case .half:
            to.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
        case .middle:
            // TODO: - calculate middle coordinates instead of string below
            to.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height / 3)
        }
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
            to.frame = finalFrame // Возвращаем на место, так он выезжает снизу
        }

        animator.addCompletion { (position) in
        // Завершаем переход, если он не был отменён
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        return animator
    }
}

extension PresentAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.animator(using: transitionContext)
        animator.startAnimation()
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        return self.animator(using: transitionContext)
    }
}

