//
//  ContextMenu+UIViewControllerTransitioningDelegate.swift
//  DemoForUIKitTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit

// MARK: UIViewControllerTransitioningDelegate. (presenting and dismissing transition)

/// When you want to present a view controller using a custom modal presentation type, set its modalPresentationStyle property to custom and assign an object that conforms to this protocol to its transitioningDelegate property. When you present that view controller, UIKit queries your transitioning delegate for the objects to use when animating the view controller into position.
extension ContextMenu: UIViewControllerTransitioningDelegate {
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let item = self.item else { return nil }
        return ContextMenuDismissing(item: item)
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let item = self.item else { return nil }
        return ContextMenuPresenting(item: item)
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        guard let item = self.item else { return nil }
        let controller = ContextMenuPresentationController(presentedViewController: presented, presenting: presenting, item: item)
        controller.contextDelegate = self
        return controller
    }

}
