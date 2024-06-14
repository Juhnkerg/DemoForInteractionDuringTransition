//
//  SourceViewCorner.swift
//  DemoForUIKitTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit

struct SourceViewCorner {

    enum Position: Int {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight

        var xModifier: CGFloat {
            switch self {
            case .topLeft, .bottomLeft: return -1
            case .topRight, .bottomRight: return 1
            }
        }

        var yModifier: CGFloat {
            switch self {
            case .topLeft, .topRight: return -1
            case .bottomLeft, .bottomRight: return 1
            }
        }

        var xSizeModifier: CGFloat {
            switch self {
            case .topLeft, .bottomLeft: return -1
            case .topRight, .bottomRight: return 0
            }
        }

        var ySizeModifier: CGFloat {
            switch self {
            case .topLeft, .topRight: return -1
            case .bottomLeft, .bottomRight: return 0
            }
        }

    }

    let rect: CGRect
    let position: Position

    var point: CGPoint {
        switch position {
        case .topLeft: return CGPoint(x: rect.minX, y: rect.minY) // x: rect.minX
        case .topRight: return CGPoint(x: rect.maxX, y: rect.minY)
        case .bottomLeft: return CGPoint(x: rect.minX, y: rect.maxY)
        case .bottomRight: return CGPoint(x: rect.maxX, y: rect.maxY)
        }
    }

}
