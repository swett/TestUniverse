//
//  ColorExtension.swift
//  TestUniverse
//
//  Created by Mykyta Kurochka on 02.11.2025.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    static var colorF1F1F5: UIColor {
        return UIColor(hexString: "#F1F1F5")
    }
    static var color1A1A1A: UIColor {
        return UIColor(hexString: "#1A1A1A")
    }
    static var color47BE9A: UIColor {
        return UIColor(hexString: "#47BE9A")
    }
    static var colorFFFFFF: UIColor {
        return UIColor(hexString: "#FFFFFF")
    }
    static var color101B18: UIColor {
        return UIColor(hexString: "#101B18")
    }
    static var colorCACACA: UIColor {
        return UIColor(hexString: "#CACACA")
    }
    
    static var color3A3C3D: UIColor {
        return UIColor(hexString: "#3A3C3D")
    }
    
    static var color808080: UIColor {
        return UIColor(hexString: "#808080")
    }
    
    static var color969696: UIColor {
        return UIColor(hexString: "#969696")
    }
    
    static var color6E6E73: UIColor {
        return UIColor(hexString: "#6E6E73")
    }
    
    
}
