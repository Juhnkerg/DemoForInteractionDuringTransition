//
//  UIColor+Extension.swift
//  DemoForInteractionDuringTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit

extension UIColor {
    // 使用示
    // let customColor = UIColor(hex: 0x509CFE)
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex >> 16) & 0xFF) / 255.0
        let green = CGFloat((hex >> 8) & 0xFF) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
