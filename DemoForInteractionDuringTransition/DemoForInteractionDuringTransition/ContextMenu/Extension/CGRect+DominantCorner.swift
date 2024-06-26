//
//  CGRect+DominantCorner.swift
//  DemoForUIKitTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit

extension CGRect {

    func dominantCorner(in rect: CGRect) -> SourceViewCorner? {
        let corners: [SourceViewCorner] = [
            SourceViewCorner(rect: rect, position: .topLeft),
            SourceViewCorner(rect: rect, position: .topRight),
            SourceViewCorner(rect: rect, position: .bottomLeft),
            SourceViewCorner(rect: rect, position: .bottomRight),
            ]

        var maxArea: CGFloat = 0
        var maxCorner: SourceViewCorner? = nil
        for corner in corners {
            let area = self.area(corner: corner)
            if area > maxArea {
                maxArea = area
                maxCorner = corner
            }
        }
        return maxCorner
    }

}
