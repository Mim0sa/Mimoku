//
//  Mimoku+UIColor.swift
//
//  Created by Mimosa.
//

import UIKit

// MARK: - Color
extension UIColor {
    // MARK: initialize with RGBA
    convenience init(withRGBA value: (CGFloat, CGFloat, CGFloat, CGFloat)) {
        self.init(red:   value.0 / 255,
                  green: value.1 / 255,
                  blue:  value.2 / 255,
                  alpha: value.3)
    }
    
    // MARK: initialize with RGB
    convenience init(withRGB value: (CGFloat, CGFloat, CGFloat)) {
        self.init(red:   value.0 / 255,
                  green: value.1 / 255,
                  blue:  value.2 / 255,
                  alpha: 1)
    }
    
    // MARK: initialize with hex & alpha
    convenience init(withHex value: (hex: UInt, alpha: CGFloat)) {
        self.init(red:   CGFloat((value.hex & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((value.hex & 0xFF0000) >> 16) / 255.0,
                  blue:  CGFloat((value.hex & 0xFF0000) >> 16) / 255.0,
                  alpha: value.alpha)
    }
    
    // MARK: initialize with hex
    convenience init(withHex hex: UInt) {
        self.init(red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hex & 0xFF00) >> 8)    / 255.0,
                  blue:  CGFloat(hex & 0xFF)             / 255.0,
                  alpha: 1)
    }
    
    // MARK: append Alpha
    func alpha(_ a: CGFloat) -> UIColor {
        var components = cgColor.components ?? [0, 0, 0]
        if components.count != 4 { components = [0, 0, 0, 0] }
        let color = UIColor(red:   components[0],
                            green: components[1],
                            blue:  components[2],
                            alpha: a)
        return color
    }
    
    // MARK: random UIColor
    static var randomColor: UIColor {
        let randomColor = UIColor(red:   CGFloat.random(in: 0...255) / 255,
                                  green: CGFloat.random(in: 0...255) / 255,
                                  blue:  CGFloat.random(in: 0...255) / 255,
                                  alpha: 1)
        return randomColor
    }
    
    // MARK: random low saturation UIColor
    static func randomLSColor(_ tolerence: (UInt, UInt) = (20, 100),
                              _ ratio: (Float, Float) = (0.6, 1)) -> UIColor {
        guard tolerence.1 <= 255 else { fatalError("tolerence should be in the range of 0...255") }
        
        func get3RandomNumber(t: (UInt, UInt)) -> [Int] {
            let r = Int.random(in: 0...255)
            let g = Int.random(in: 0...255)
            let b = Int.random(in: 0...255)
            let numbers = [r, g, b]
            let offset = numbers.max()! - numbers.min()!
            if offset < t.1
                && offset > t.0
                && (r + g + b) > Int(765 * ratio.0)
                && (r + g + b) < Int(765 * ratio.1) {
                return numbers
            } else {
                return get3RandomNumber(t: t)
            }
        }
        
        let colors: [CGFloat] = get3RandomNumber(t: tolerence).map { (c) -> CGFloat in return CGFloat(c) }
        return UIColor(red:   colors[0] / 255.0,
                       green: colors[1] / 255.0,
                       blue:  colors[2] / 255.0,
                       alpha: 1)
    }
}

// MARK: - Control
extension UIColor {
    // MARK: initialize with name
    convenience init?(_ name: String) {
        self.init(named: name)
    }
    
    // MARK: resolved CGColor
    func cgColor(with traitCollection: UITraitCollection) -> CGColor {
        return resolvedColor(with: traitCollection).cgColor
    }
}

