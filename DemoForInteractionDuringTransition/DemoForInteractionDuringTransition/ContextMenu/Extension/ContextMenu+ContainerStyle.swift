//
//  ContextMenu+ContainerStyle.swift
//  DemoForUIKitTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit

// Set the container style and slightly adjust the x and y axis positions
extension ContextMenu {

    /// Appearance properties for the menu container.
    public struct ContainerStyle {

        /// The corner radius of the menu container.
        public let cornerRadius: CGFloat

        /// The shadow radius of the menu container.
        public let shadowRadius: CGFloat

        /// The shadow opacity of the menu container. The shadow color is `UIColor.black`.
        public let shadowOpacity: Float

        /// The shadow offset of the menu container.
        public let shadowOffset: CGSize

        /// The padding from the source-view corner to apply to the x-axis. Positive is further away.
        public let xPadding: CGFloat

        /// The padding from the source-view corner to apply to the y-axis. Positive is further away.
        public let yPadding: CGFloat

        /// Padding applied to the screen edge for minimum and maximum positioning of the menu. Prevents clipping.
        public let edgePadding: CGFloat

        /// The background color of the menu, applied to the container, navigation bar, and content views.
        public let backgroundColor: UIColor

        /// The background color to overlay behind the menu. Must set an `alpha` value to be transparent.
        public let overlayColor: UIColor

        /// A flag indicating if device gyro effects should be applied.
        /// If the user has enabled Reduce Motion in Settings, this will be ignored.
        public let motionEffect: Bool

        public init(
            cornerRadius: CGFloat = 8,
            shadowRadius: CGFloat = 10,
            shadowOpacity: Float = 0.4,
            shadowOffset: CGSize = CGSize(width: 0, height: 2),
            xPadding: CGFloat = -8, // -8 // 这个是控制view的x轴的位置的，定为 -15 iPad上还好，iPhone上不行可能是怼到边了。可在初始化时设置
            yPadding: CGFloat = 8, // 8
            edgePadding: CGFloat = 15,
            backgroundColor: UIColor = .white,
            overlayColor: UIColor = UIColor(white: 0, alpha: 0.3),
            motionEffect: Bool = true
            ) {
            self.cornerRadius = cornerRadius
            self.shadowRadius = shadowRadius
            self.shadowOpacity = shadowOpacity
            self.shadowOffset = shadowOffset
            self.xPadding = xPadding
            self.yPadding = yPadding
            self.edgePadding = edgePadding
            self.backgroundColor = backgroundColor
            self.overlayColor = overlayColor
            self.motionEffect = motionEffect
        }

    }

}
