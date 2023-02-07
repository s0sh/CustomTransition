//
//  UIView+extentions.swift
//  Transitions
//
//  Created by Roman Bigun on 11.08.2022.
//
import UIKit

enum ViewPositioning {
  case fullscreen
  case middle
  case small
}

/// Nib
extension UIView {
   
    // Add subview
    func addSubviewUsingConstraints(view: UIView,
                                    insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        NSLayoutConstraint.activate([view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
                                     view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
                                     trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right),
                                     bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)])
    }
    
    func insertSubviewUsingConstraints(view: UIView,
                                       insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
                                       atIndex: Int) {
        view.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(view, at: atIndex)
        
        NSLayoutConstraint.activate([view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
                                     view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
                                     trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right),
                                     bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom)])
    }
    
    func addSuperviewUsingConstraints(superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        let views = ["view": self]
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                metrics: nil,
                                                                views: views))
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                metrics: nil,
                                                                views: views))
    }
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
           layer.masksToBounds = false
           layer.shadowOffset = offset
           layer.shadowColor = color.cgColor
           layer.shadowRadius = radius
           layer.shadowOpacity = opacity

           let backgroundCGColor = backgroundColor?.cgColor
           backgroundColor = nil
           layer.backgroundColor =  backgroundCGColor
       }
}

// Animations
extension UIView {
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.4
        animation.values = [-4, 4, -4, 4, -4, 4]
        layer.add(animation, forKey: "shake")
    }
    
    class func animate(_ animations: @escaping (() -> Void), completion: (() -> Void)? = nil) {
        UIView.animate(withDecision: true,
                       animations: animations,
                       completion: completion)
    }
    
    class func animate(withDecision isAnimated: Bool,
                       duration: TimeInterval = 0.4,
                       animationCurve: UIView.AnimationCurve? = nil,
                       animations: @escaping (() -> Void),
                       completion: (() -> Void)? = nil) {
        guard isAnimated else {
            animations()
            completion?()
            return
        }
        
        let parameters = UICubicTimingParameters(controlPoint1: CGPoint(x: 0.230, y: 1.000),
                                                 controlPoint2: CGPoint(x: 0.320, y: 1.000))
        let animator: UIViewPropertyAnimator
        if let animationCurve = animationCurve {
            animator = UIViewPropertyAnimator(duration: duration,
                                              curve: animationCurve)
        } else {
            animator = UIViewPropertyAnimator(duration: duration,
                                              timingParameters: parameters)
        }
        
        animator.addAnimations(animations)
        animator.addCompletion { _ in
            completion?()
        }
        animator.startAnimation()
    }
    
    func performFadeTransition(duration: CFTimeInterval = 0.15) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

/// Shadow, Corners
extension UIView {
    func roundTopCorners(_ topCornerRadius: CGFloat = 12) {
        self.clipsToBounds = true
        layer.cornerRadius = topCornerRadius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
    }
    
    func roundTopCornersWithMask(_ topCornerRadius: CGFloat = 12) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: topCornerRadius, height: topCornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
        layer.masksToBounds = true
    }
    
    func roundCorners(_ cornerRadius: CGFloat = 12) {
        self.clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.masksToBounds = true
    }
    
    func roundedBottom(cornerRadius: CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func addBottomShadow(color: UIColor = UIColor.black.withAlphaComponent(0.06),
                         radius: CGFloat = 8,
                         height: CGFloat = 2,
                         shadowOpacity: Float = 1.0) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = shadowOpacity.clamped(to: 0.0...1.0)
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: height)
    }
    
    func addBottomShadowDark(color: UIColor = UIColor.black.withAlphaComponent(0.2),
                             radius: CGFloat = 8,
                             height: CGFloat = 10,
                             shadowOpacity: Float = 1.0) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = shadowOpacity.clamped(to: 0.0...1.0)
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: height)
    }
    
    func addGrayShadow() {
        let shadows = UIView()
        shadows.frame = frame
        shadows.clipsToBounds = false
        insertSubview(shadows, at: 0)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.frame, cornerRadius: 8)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 8
        layer0.shadowOffset = CGSize(width: 0, height: 2)
        layer0.bounds = shadows.frame
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)

        let shapes = UIView()
        shapes.frame = frame
        shapes.clipsToBounds = true
        addSubview(shapes)

        let layer1 = CALayer()
        layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer1.bounds = shapes.frame
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)
        shapes.layer.cornerRadius = 8
    }
    
    func updateShadowPath() {
        let path: CGPath
        
        if layer.cornerRadius > 0 {
            path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        } else if let superViewCorner = superview?.layer.cornerRadius, superViewCorner > 0 {
            path = UIBezierPath(roundedRect: bounds, cornerRadius: superViewCorner).cgPath
        } else {
            path = UIBezierPath(rect: bounds).cgPath
        }
        layer.shadowPath = path
    }
    
    func setCornerRadius(radius: CGFloat = 8) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
    func convertToImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    func showInfoView(text: String, downFromCenter: CGFloat = 100) {
        let infoView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 85))
        infoView.backgroundColor = UIColor.white
        infoView.alpha = 0.0
        infoView.layer.cornerRadius = 8.0
        infoView.addBottomShadow()
        addSubview(infoView)
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([infoView.heightAnchor.constraint(equalToConstant: 85),
                                     infoView.widthAnchor.constraint(equalToConstant: 150),
                                     infoView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     infoView.centerYAnchor.constraint(equalTo: centerYAnchor,
                                                                      constant: downFromCenter)])
        
        let label = UILabel()
        label.text = text
        label.font = UIFont.init(name: "Tahoma", size: 24.0)
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        infoView.addSubviewUsingConstraints(view: label,
                                            insets: UIEdgeInsets(top: 12, left: 6, bottom: 12, right: 6))
        
        UIView.animate(withDecision: true, duration: 0.5, animationCurve: nil, animations: {
            infoView.alpha = 1.0
        }) {
            UIView.animate(withDuration: 0.7, animations: {
                infoView.alpha = 0.0
            }) { _ in
                infoView.removeFromSuperview()
            }
        }
    }
    
    var globalFrame: CGRect? {
        let rootView = UIApplication.shared.keyWindow?.rootViewController?.view
        return self.superview?.convert(self.frame, to: rootView)
    }
}

class PauseViewGradient: UIView {

    var startColor: UIColor = UIColor(hexString: "EC670C").withAlphaComponent(0.8)
    var endColor: UIColor = UIColor(hexString: "E57C37").withAlphaComponent(0.8)

    override func draw(_ rect: CGRect) {

      let context = UIGraphicsGetCurrentContext()!
      let colors = [startColor.cgColor, endColor.cgColor]

      let colorSpace = CGColorSpaceCreateDeviceRGB()

      let colorLocations: [CGFloat] = [0.0, 1.0]

      let gradient = CGGradient(colorsSpace: colorSpace,
                                     colors: colors as CFArray,
                                  locations: colorLocations)!

      let startPoint = CGPoint.zero
      let endPoint = CGPoint(x: 0, y: bounds.height)
      context.drawLinearGradient(gradient,
                          start: startPoint,
                            end: endPoint,
                        options: [CGGradientDrawingOptions(rawValue: 0)])
    }
}

extension UIView {

    var isVisible: Bool {
        get {
            return !isHidden
        }
        set {
            if superview is UIStackView {
                if isHidden == newValue {
                    isHidden = !newValue
                }
            } else {
                isHidden = !newValue
            }
        }
    }
    
    var capturedImage: UIImage? {
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
