//
//  ContextMenu+Animations.swift
//  DemoForUIKitTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit

// - 在这里设置动画参数和时间
extension ContextMenu {

    /// Animation durations and properties.
    public struct AnimationDurations {

        /// The duration of the presentation animation.
        public let present: TimeInterval

        /// The duration of the spring animation during presentation. Setting a longer duration than `present` results
        /// in a more natural transition.
        public let springPresent: TimeInterval

        /// The spring damping to use in the presentation. See `UIView.animate(withDuration:, delay:,
        /// usingSpringWithDamping:, initialSpringVelocity:, options:, animations: , completion:)`
        public let springDamping: CGFloat

        /// The spring velocity to use in the presentation. See `UIView.animate(withDuration:, delay:,
        /// usingSpringWithDamping:, initialSpringVelocity:, options:, animations: , completion:)`
        public let springVelocity: CGFloat

        /// The duration of the dismiss animation.
        public let dismiss: TimeInterval

        /// The animation duration when the `preferredContentSize` changes.
        public let resize: TimeInterval

        /// present: TimeInterval = 0.3, 越小背景展示越快，能快速响应点击手势 （试试0.15）
//        public init(
//            present: TimeInterval = 0.3,
//            springPresent: TimeInterval = 0.5,
//            springDamping: CGFloat = 0.8,
//            springVelocity: CGFloat = 0.5,
//            dismiss: TimeInterval = 0.15,
//            resize: TimeInterval = 0.3
//            ) {
//            self.present = present
//            self.springPresent = springPresent
//            self.springDamping = springDamping
//            self.springVelocity = springVelocity
//            self.dismiss = dismiss
//            self.resize = resize
//        }
        public init(
            present: TimeInterval = 0.35,//0.25,
            springPresent: TimeInterval = 0.37,
            springDamping: CGFloat = 0.7293,
            springVelocity: CGFloat = 0.5, // 0.1 好像不错
            dismiss: TimeInterval = 0.135,
            resize: TimeInterval = 0.28
            ) {
            self.present = present
            self.springPresent = springPresent
            self.springDamping = springDamping
            self.springVelocity = springVelocity
            self.dismiss = dismiss
            self.resize = resize
        }
    }

}
