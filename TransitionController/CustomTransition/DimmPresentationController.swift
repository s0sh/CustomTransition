//
//  DimmPresentationController.swift
//  TransitionController
//
//  Created by Roman Bigun on 11.08.2022.
//

import UIKit

class DimmPresentationController: PresentationController {
    private lazy var dimmView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        view.alpha = 0
        return view
    }()
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.insertSubview(dimmView, at: 0)
        performAlongsideTransitionIfPossible { [unowned self] in
            self.dimmView.alpha = 1
        }
    }
    
    private func performAlongsideTransitionIfPossible(_ block: @escaping () -> Void) {
        guard let coordinator = self.presentedViewController.transitionCoordinator else {
            block()
            return
        }

        coordinator.animate(alongsideTransition: { (_) in
            block()
        }, completion: nil)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        dimmView.frame = containerView!.frame
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        if !completed {
            self.dimmView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        performAlongsideTransitionIfPossible { [unowned self] in
            self.dimmView.alpha = 0
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        if completed {
            self.dimmView.removeFromSuperview()
        }
    }
}
