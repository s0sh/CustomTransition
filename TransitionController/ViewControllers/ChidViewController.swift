//
//  ParentViewController.swift
//  TransitionController
//
//  Created by Roman Bigun on 08.08.2022.
//

import Foundation
import UIKit

class ChildViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .orange
        view.roundCorners()
        view.addBottomShadow()
    }
    
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissAction))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func dismissAction() {
        dismiss(animated: true)
    }
}
