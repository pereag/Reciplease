//
//  GradientView.swift
//  Reciplease
//
//  Created by Valc0d3 on 10/10/2022.
//

import UIKit

final class GradientView: UIView {
    // Layer from UIView, considered as class LinearGradientLayer
    lazy var gradientLayer = layer as? LinearGradientLayer
    
    // In order to use Layer, we have to specifize its class
    override class var layerClass: AnyClass {
        return LinearGradientLayer.self
    }
    
    // Update gradient with its direction (enum) and [UIColor]
    func updateGradient(with direction: LinearGradientLayer.Direction, colors: UIColor...) {
        gradientLayer?.direction = direction
        gradientLayer?.colors = colors.map { $0.cgColor}
        gradientLayer?.setNeedsDisplay()
    }
}
