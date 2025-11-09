//
//  HexExtension.swift
//  ivvlivanovPW2
//
//  Created by Иван Иванов on 31.10.2025.
//

import UIKit

extension UIColor {
    var hex: Int { //HW3
            var red: CGFloat = 0 //HW3
            var green: CGFloat = 0 //HW3
            var blue: CGFloat = 0 //HW3
            var alpha: CGFloat = 0 //HW3
            getRed(&red, green: &green, blue: &blue, alpha: &alpha) //HW3
            let rgb = (Int)(red*255)<<16 | (Int)(green*255)<<8 | (Int)(blue*255)<<0 //HW3
            return rgb //HW3
        } //HW3

        convenience init(hex: Int) {
            let r = CGFloat((hex >> 16) & 0xFF) / 255.0
            let g = CGFloat((hex >> 8) & 0xFF) / 255.0
            let b = CGFloat(hex & 0xFF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: 1.0)
        }
}
