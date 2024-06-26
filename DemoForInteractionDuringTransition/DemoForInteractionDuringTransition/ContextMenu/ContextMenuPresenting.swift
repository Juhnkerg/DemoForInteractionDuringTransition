//
//  ContextMenuPresenting.swift
//  DemoForUIKitTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit

class ContextMenuPresenting: NSObject, UIViewControllerAnimatedTransitioning {

    private let item: ContextMenu.Item

    init(item: ContextMenu.Item) {
        self.item = item
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            // Handle the case where the view controllers are not available
            transitionContext.completeTransition(false)
            return
        }

        let containerView = transitionContext.containerView

        containerView.addSubview(toViewController.view)
        
        
        toViewController.view.alpha = 0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toViewController.view.alpha = 1
        }) { _ in
            transitionContext.completeTransition(true)
        }  
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return item.options.durations.present // 0.25
    }

}
