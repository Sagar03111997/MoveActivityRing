//
//  ActivityRingView.swift
//  Mental-Health-App-iOS
//
//  Created by Sagar Sahu on 11/23/23.
//

import UIKit

struct ActivityRing {
    var color: UIColor
    var gradientColor: UIColor
    var progress: CGFloat
}

class MultipleActivityRingsView: UIView {
    var rings: [ActivityRing] = [] // The rings to be drawn
    var ringWidth: CGFloat = 14 // The width of each ring
    
    // Initializer
    init(frame: CGRect, rings: [ActivityRing], ringWidth: CGFloat) {
        self.rings = rings
        self.ringWidth = ringWidth
        super.init(frame: frame)
        self.backgroundColor = .clear // Ensure the background is transparent
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Custom drawing
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.sublayers?.forEach { $0.removeFromSuperlayer() } // Clean up old layers
        drawRings()
    }
    
    private func drawRings() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        var radius = (min(bounds.width, bounds.height) / 2) - ringWidth
        
        for ring in rings { // Draw in reverse order to stack correctly
            drawRing(center: center, radius: radius, color: ring.color, gradientColor: ring.gradientColor, progress: ring.progress)
            radius -= ringWidth // Decrease the radius for the next ring
        }
        
    }
    
    private func drawRing(center: CGPoint, radius: CGFloat, color: UIColor, gradientColor: UIColor, progress: CGFloat) {
        // Full ring path for the background
        let backgroundPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        // CAShapeLayer for the background ring
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.path = backgroundPath.cgPath
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = color.withAlphaComponent(0.2).cgColor // Lighter shade for background
        backgroundLayer.lineWidth = ringWidth
        backgroundLayer.lineCap = .round
        layer.addSublayer(backgroundLayer)
        
        // Progress ring path
        let progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: (-CGFloat.pi / 2) + (2 * CGFloat.pi * progress), clockwise: true)
        
        // CAShapeLayer for the progress ring with the gradient
        let progressLayer = CAShapeLayer()
        progressLayer.path = progressPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.black.cgColor // This will be the mask for the gradient
        progressLayer.lineWidth = ringWidth
        progressLayer.lineCap = .round
        
        // Gradient layer for the progress part
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [gradientColor.withAlphaComponent(0).cgColor, gradientColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.frame = CGRect(x: 0, y: 1.0, width: bounds.width, height: bounds.height)
        gradientLayer.mask = progressLayer // Mask the gradient with the progress layer
        
        // Add the progress ring with gradient on top of the background layer
        layer.addSublayer(gradientLayer)
    }
}






