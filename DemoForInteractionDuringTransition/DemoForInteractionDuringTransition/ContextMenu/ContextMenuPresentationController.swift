//
//  ContextMenuPresentationController.swift
//  DemoForUIKitTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit

// Used to close and render another Viewcontroller.
protocol DismissContextMenuAndPrensentNextVCDelegate: AnyObject {
    func didTapCloseAndPresentNext(toViewController: UIViewController?)
}

protocol ContextMenuPresentationControllerDelegate: AnyObject {
    func willDismiss(presentationController: ContextMenuPresentationController)
}

// MARK:  ContextMenuPresentationController used to manage the rendering or dissolution of the view and animated objects

/// The UIPresentationController class defines specific entry points for manipulating the view hierarchy when presenting a view controller. When a view controller is about to be presented, UIKit calls the presentation controller’s【 presentationTransitionWillBegin()】 method. You can use that method to add views to the view hierarchy and set up any animations related to those views. At the end of the presentation phase, UIKit calls the presentationTransitionDidEnd(_:) method to let you know that the transition finished.
class ContextMenuPresentationController: UIPresentationController {

    weak var contextDelegate: ContextMenuPresentationControllerDelegate?
    weak var dismissToNextVCDelegate: DismissContextMenuAndPrensentNextVCDelegate?
    let item: ContextMenu.Item
    var keyboardSpace: CGFloat = 0

    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, item: ContextMenu.Item) {
        
        self.item = item
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboard(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboard(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboard(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = item.options.containerStyle.overlayColor.withAlphaComponent(0.12)
        return view
    }()

    var preferredSourceViewCorner: SourceViewCorner? {
        guard let sourceViewFrame = item.sourceView?.frame,
            let containerView = self.containerView,
            let frame = item.sourceView?.superview?.convert(sourceViewFrame, to: containerView)
            else { return nil}

        return containerView.bounds.dominantCorner(in: frame)
    }

    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerBounds = containerView?.bounds else { return .zero }
        var size = presentedViewController.preferredContentSize

        // cap size to inset container bounds
        size.width = min(containerBounds.width - 2 * item.options.containerStyle.edgePadding, size.width)
        size.height = min(containerBounds.height - 2 * item.options.containerStyle.edgePadding, size.height)

        let frame: CGRect
        if let corner = preferredSourceViewCorner {
            let minPadding = item.options.containerStyle.edgePadding
            let y = corner.point.y
                + corner.position.ySizeModifier * size.height
                + corner.position.yModifier * item.options.containerStyle.yPadding

            let x: CGFloat
            switch item.options.position {
            case .default:
                x = corner.point.x
                    + corner.position.xSizeModifier * size.width
                    + corner.position.xModifier * item.options.containerStyle.xPadding
            case .centerX:
                x = corner.rect.midX - size.width / 2
            }

            frame = CGRect(
                x: max(minPadding, min(containerBounds.width - size.width - minPadding, x)),
                y: max(minPadding, min(containerBounds.height - size.height - minPadding, y)),
                width: size.width,
                height: size.height
            )
        } else {
            frame = CGRect(
                x: (containerBounds.width - size.width)/2,
                y: (containerBounds.height - keyboardSpace - size.height)/2,
                width: size.width,
                height: size.height
            )
        }
        return frame.integral
    }

    override func containerViewWillLayoutSubviews() {
        guard let containerView = self.containerView else { return }
        let frame = frameOfPresentedViewInContainerView
        if frame != .zero {
            presentedView?.frame = frame
        }
        overlayView.frame = containerView.bounds
    }

    //  CATransform3D
    var presentedViewTransform: CATransform3D {
        let translate: CATransform3D
        if let corner = preferredSourceViewCorner {
            let point: CGPoint
            if case .centerX = item.options.position,
                let sourceView = item.sourceView,
                let containerView = self.containerView,
                let center = sourceView.superview?.convert(sourceView.center, to: containerView) {
                point = center
            } else {
                point = corner.point
            }

            let frame = frameOfPresentedViewInContainerView
            let center = CGPoint(x: frame.minX + frame.width / 2, y: frame.minY + frame.height / 2)
            translate = CATransform3DMakeTranslation(point.x - center.x, point.y - center.y, 0)
        } else {
            translate = CATransform3DIdentity
        }
        let scale: CGFloat = item.sourceView == nil ? 0.8 : 0.21
        return CATransform3DScale(translate, scale, scale, 1)
    }

    /// The UIPresentationController class defines specific entry points for manipulating the view hierarchy when presenting a view controller. When a view controller is about to be presented, UIKit calls the presentation controller’s【 presentationTransitionWillBegin()】 method. You can use that method to add views to the view hierarchy and set up any animations related to those views. At the end of the presentation phase, UIKit calls the presentationTransitionDidEnd(_:) method to let you know that the transition finished.
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let containerView = self.containerView,
            let coordinator = presentedViewController.transitionCoordinator
            else { return }

        containerView.insertSubview(overlayView, at: 0)

        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap(recognizer:)))
        tap.cancelsTouchesInView = false
        containerView.addGestureRecognizer(tap)

        overlayView.alpha = 0
        coordinator.animate(alongsideTransition: { _ in
            self.overlayView.alpha = 1
        })

        presentedView?.layer.transform = presentedViewTransform

        UIView.animate(
            withDuration: item.options.durations.springPresent,
            delay: 0,
            usingSpringWithDamping: item.options.durations.springDamping,
            initialSpringVelocity: item.options.durations.springVelocity,
            animations: {
                self.presentedView?.layer.transform = CATransform3DIdentity
        })
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        contextDelegate?.willDismiss(presentationController: self)
        guard let coordinator = presentedViewController.transitionCoordinator else { return }
        coordinator.animate(alongsideTransition: { _ in
            self.presentedView?.layer.transform = self.presentedViewTransform
            self.overlayView.alpha = 0
        })
    }

    @objc func onTap(recognizer: UITapGestureRecognizer) {
        guard recognizer.state == .ended,
            let containerView = self.containerView,
            presentedView?.frame.contains(recognizer.location(in: containerView)) == false
            else { return }
        presentingViewController.dismiss(animated: true)
    }

    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        guard let containerView = self.containerView else { return }
        UIView.animate(withDuration: item.options.durations.resize) {
            containerView.setNeedsLayout()
            containerView.layoutIfNeeded()
        }
    }

    @objc func onKeyboard(notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let containerView = self.containerView
            else { return }
        keyboardSpace = containerView.bounds.height - frame.minY
        UIView.animate(withDuration: duration) {
            containerView.setNeedsLayout()
            containerView.layoutIfNeeded()
        }
    }
}
