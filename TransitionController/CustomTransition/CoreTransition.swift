//
//  CoreTransition.swift
//  TransitionController
//
//  Created by Roman Bigun on 11.08.2022.
//
import UIKit
import Foundation

class CoreTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    var duration: TimeInterval = 0.3
    let position: TransitionPosition
    
    init(duration: Double, position: TransitionPosition) {
        self.duration = duration
        self.position = position
    }
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return DimmPresentationController(presentedViewController: presented,
                                                               presenting: presenting ?? source)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation(duration: duration, position: position)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }
}
