//
//  CoreAnimationViewController.swift
//  xcconfig_template
//
//  Created by Ara Hakobyan on 18.02.21.
//  Copyright © 2021 Ara Hakobyan. All rights reserved.
//

import UIKit

class CoreAnimationViewController: UIViewController {
    var animation: CABasicAnimation!
    
    private let shapeLayer = CAShapeLayer()
    
    private lazy var myView: UIView = {
        let view = UIView(frame: .init(x: 0, y: 200, width: 100, height: 100))
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.center = self.view.center
//        view.isHidden = true
        return view
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(myView)
        view.layer.addSublayer(shapeLayer)
        
        view.addSubview(activityIndicator)
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(gestureAction)))
        view.layer.addSublayer(shapeLayer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        buildAnimations()
        buildShapeLayer()
        
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.path = createPath(point: CGPoint(x: view.bounds.maxX / 2, y: view.bounds.minY))
    }
    
    @objc func gestureAction(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: view)
        
        struct AnimationSetting {
            static var isAnimation = false
            static var isLoading = false
        }

        switch sender.state {
        case .began:
            AnimationSetting.isAnimation = point.y < 40
            if AnimationSetting.isAnimation {
                shapeLayer.removeAllAnimations()
            }
        case .changed:
            guard AnimationSetting.isAnimation else { return }
            shapeLayer.path = createPath(point: point)
        case .ended, .failed, .cancelled:
            guard AnimationSetting.isAnimation else { return }
            animationStartingPosition(fromPoint: point)
        default: break
        }
    }
    
    func createPath(point: CGPoint) -> CGPath {
        let bezierPath = UIBezierPath()
        
        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: view.bounds.maxX, y: view.bounds.minY)
        bezierPath.move(to: startPoint)
        bezierPath.addCurve(to: endPoint, controlPoint1: point, controlPoint2: point)
        bezierPath.close()
        
        return bezierPath.cgPath
    }
    
    func animationStartingPosition(fromPoint: CGPoint) {
        let animation = CASpringAnimation(keyPath: "path")
        animation.fromValue = createPath(point: fromPoint)
        animation.toValue = createPath(point: CGPoint(x: view.bounds.maxX / 2, y: view.bounds.minY))
        
        animation.damping = 10
        animation.initialVelocity = 20.0
        animation.mass = 2.0
        animation.stiffness = 1000.0
        
        animation.duration = animation.settlingDuration
        
        animation.delegate = self
        shapeLayer.add(animation, forKey: nil)
        
        shapeLayer.path = createPath(point: CGPoint(x: view.bounds.maxX / 2, y: view.bounds.minY))
    }
}

extension CoreAnimationViewController {
    
    private func buildAnimations() {
        animation = buildPositionXAnimation(from: 0, to: view.bounds.width)
        animation.delegate = self
        myView.layer.add(animation, forKey: nil)

        let scaleAnimation = buildScaleAnimation(from: 1.0, to: 2.0)
        myView.layer.add(scaleAnimation, forKey: nil)
        
        let shapeAnimation = buildPositionXAnimation(from: view.center.x - 150, to: view.bounds.width - 150)
        shapeLayer.add(shapeAnimation, forKey: nil)
    }
    
    private func buildShapeLayer() {
        let path = UIBezierPath()
        path.move(to: view.center)
        path.addCurve(to: view.center,
                      controlPoint1: CGPoint(x: view.center.x + 150, y: view.center.y + 150),
                      controlPoint2: CGPoint(x: view.center.x - 150, y: view.center.y + 150))
        
        path.lineWidth = 2
        
        shapeLayer.fillColor = UIColor.orange.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.path = path.cgPath
    }
    
    private func buildPositionXAnimation(
        from: CGFloat,
        to: CGFloat,
        duration: Double = 0.5,
        beginTime: Double = 0.3,
        repeatCount: Float = 4,
        autoreverses: Bool = true
    ) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = from
        animation.toValue = to
        animation.duration = duration
        animation.beginTime = CACurrentMediaTime() + beginTime
        animation.repeatCount = repeatCount
        animation.autoreverses = autoreverses
        return animation
    }
    
    private func buildScaleAnimation(
        from: CGFloat,
        to: CGFloat,
        repeatCount: Float = 2,
        autoreverses: Bool = true
    ) -> CABasicAnimation {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.damping = 10
        animation.mass = 1
        animation.initialVelocity = 100
        animation.stiffness = 1500.0
        
        animation.fromValue = from
        animation.toValue = to
        animation.duration = animation.settlingDuration
        animation.repeatCount = repeatCount
        animation.autoreverses = autoreverses
        return animation
    }
}

extension CoreAnimationViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        print("animation did start")
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("animation did finish")
        
        shapeLayer.removeAllAnimations()
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()

    }
}
