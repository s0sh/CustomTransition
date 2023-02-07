//
//  PresentationController.swift
//  TransitionController
//
//  Created by Roman Bigun on 11.08.2022.
//

import UIKit

class PresentationController: UIPresentationController {
    
    var position: TransitionPosition = .half
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        switch position {
        case .full:
             return CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        case .half:
            let halfHeight = bounds.height / 2
            return CGRect(x: 0, y: halfHeight, width: bounds.width, height: halfHeight)
        case .middle:
            let halfHeight = bounds.height / 3
            return CGRect(x: 16, y: halfHeight, width: bounds.width - 32.0, height: halfHeight)
        }
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.addSubview(presentedView!)
    }
    
    override func containerViewDidLayoutSubviews() {
            super.containerViewDidLayoutSubviews()
            presentedView?.frame = frameOfPresentedViewInContainerView
    }
}
