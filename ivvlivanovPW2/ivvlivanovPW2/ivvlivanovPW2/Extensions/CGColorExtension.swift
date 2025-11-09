//
//  File.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 31.10.2025.
//

import UIKit

extension CGColor { //HW3
    var hexValue: Int { //HW3
        guard let components = self.components else { return 0 } //HW3
        let red = Int((components[0] * 255).rounded()) //HW3
        let green = Int((components[1] * 255).rounded()) //HW3
        let blue = Int((components[2] * 255).rounded()) //HW3
        return (red << 16) | (green << 8) | blue
    } //HW3
    static func from(hex: Int) -> CGColor { //HW3
        let r = CGFloat((hex >> 16) & 0xFF) / 255.0 //HW3
        let g = CGFloat((hex >> 8) & 0xFF) / 255.0 //HW3
        let b = CGFloat(hex & 0xFF) / 255.0 //HW3
        return CGColor(red: r, green: g, blue: b, alpha: 1.0) //HW3
    } //HW3
} //HW3
