//
//  ViewController.swift
//  TransitionController
//
//  Created by Roman Bigun on 08.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let transition = CoreTransition(duration: 1.2, position: .half)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func openDidPress(_ sender: Any) {
        let child = ChildViewController()
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        present(child, animated: true)
    }
}
