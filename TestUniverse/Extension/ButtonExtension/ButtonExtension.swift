//
//  ButtonExtension.swift
//  TestUniverse
//
//  Created by Mykyta Kurochka on 02.11.2025.
//

import Foundation
import UIKit

extension UIButton {
    func addShadow(color: UIColor = .black, opacity: Float = 0.2, offset: CGSize = .zero, radius: CGFloat = 1) {
        layer.masksToBounds = false // Crucial for shadows to be visible outside the button's bounds
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shouldRasterize = true // Improves performance by caching the rendered shadow
        layer.rasterizationScale = UIScreen.main.scale // Ensures proper scaling on different screen resolutions
    }
}
