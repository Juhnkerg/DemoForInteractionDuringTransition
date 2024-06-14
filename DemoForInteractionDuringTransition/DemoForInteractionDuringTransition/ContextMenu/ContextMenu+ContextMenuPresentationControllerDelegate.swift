//
//  ContextMenu+ContextMenuPresentationControllerDelegate.swift
//  DemoForUIKitTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit

extension ContextMenu: ContextMenuPresentationControllerDelegate {

    func willDismiss(presentationController: ContextMenuPresentationController) {
        guard item?.viewController === presentationController.presentedViewController else { return }
        item = nil
    }

}
