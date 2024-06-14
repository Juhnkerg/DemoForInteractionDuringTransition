//
//  File.swift
///  DemoForUIKitTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit

extension ContextMenu {

    class Item {

        let options: Options
        let viewController: ClippedContainerViewController

        weak var sourceView: UIView?
        weak var delegate: ContextMenuDelegate?

        init(
            viewController: UIViewController,
            options: Options,
            sourceView: UIView?,
            delegate: ContextMenuDelegate?
            ) {
            self.viewController = ClippedContainerViewController(options: options, viewController: viewController)
            self.options = options
            self.sourceView = sourceView
            self.delegate = delegate
        }
    }

}
