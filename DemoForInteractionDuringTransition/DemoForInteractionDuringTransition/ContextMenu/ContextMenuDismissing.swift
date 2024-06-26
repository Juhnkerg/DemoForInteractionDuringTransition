//
//  ContextMenuDismissing.swift
//  DemoForUIKitTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit

class ContextMenuDismissing: NSObject, UIViewControllerAnimatedTransitioning {

    private let item: ContextMenu.Item

    init(item: ContextMenu.Item) {
        self.item = item
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }

        let delegate = item.delegate
        let viewController = item.viewController.viewController
        let animated = transitionContext.isAnimated
        delegate?.contextMenuWillDismiss(viewController: viewController, animated: animated)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromViewController.view.alpha = 0
        }) { _ in
            delegate?.contextMenuDidDismiss(viewController: viewController, animated: animated)
            transitionContext.completeTransition(true)
        }
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return item.options.durations.dismiss
    }

}
