//
//  ContextMenuDelegate.swift
//  DemoForUIKitTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit

public protocol ContextMenuDelegate: AnyObject {
    func contextMenuWillDismiss(viewController: UIViewController, animated: Bool)
    func contextMenuDidDismiss(viewController: UIViewController, animated: Bool)
}
