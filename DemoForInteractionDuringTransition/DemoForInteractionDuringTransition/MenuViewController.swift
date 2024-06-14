//
//  MenuViewController.swift
//  DemoForInteractionDuringTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit

class MenuViewController: UITableViewController {
    weak var delegate: DismissContextMenuAndPrensentNextVCDelegate? // 用于关闭自身并呈现另一个controller (其实是利用协议实现viewcontroller的反向传值，另一种反向传值的方式是闭包参数来进行传值)
    
    let rows = arc4random_uniform(4) + 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "菜单栏"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isScrollEnabled = false // 禁止滚动
        tableView.reloadData()
        tableView.layoutIfNeeded()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        tableView.backgroundColor = .clear
        
        settingPreferredContentSize()
    }
    
    // -设置 preferredContentSize 的值
    private func settingPreferredContentSize() {
        let screenSize = UIScreen.main.bounds.size
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.preferredContentSize = CGSize(width: screenSize.width * 0.8, height: tableView.contentSize.height)
        } else {
            self.preferredContentSize = CGSize(width: screenSize.width * 0.6, height: tableView.contentSize.height)
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return Int(rows)
        return Menu.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let menu = Menu(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.imageView?.image = menu.image
        cell.textLabel?.text = menu.name //"菜单 \(indexPath.row)"
        cell.textLabel?.font = .boldSystemFont(ofSize: 17)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        cell.accessoryType = .disclosureIndicator
        
        // 设置 cell 的选中样式为 .default
        cell.selectionStyle = .default
        
        // 创建一个背景视图并设置背景颜色
        let backgroundView = UIView()
        backgroundView.backgroundColor = .init(hex: 0x435163).withAlphaComponent(0.6)// 设置你想要的选中颜色
        
        // 将背景视图赋值给 cell 的 selectedBackgroundView 属性
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }

    // TODO: 如何关闭整个菜单，并显示另一个controllerView？用父controller的delegate吗？
    // 试试参照 AnimatedTransitionDemo 的实现
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) // 设置为false能呈现 点击后只闪一下背景，不会一直显示背景。【不过默认的背景色得换？——真机上选中不是模拟器上的白色背景】
//        self.dismiss(animated: true)
        
        guard let menu = Menu(rawValue: indexPath.row) else { return }
        
        let next = menu.nextViewController
        
        // 关闭当前ViewController
        presentingViewController?.dismiss(animated: true)
        
        // 通知代理执行操作
        delegate?.didTapCloseAndPresentNext(toViewController: next)
        
//        navigationController?.pushViewController(MenuViewController(), animated: true)
    }

}

// 菜单选项-enum
extension MenuViewController {
    enum Menu: Int, CaseIterable {
        case `default`
        case one
        case two
        case three
        
        var name: String {
            let name: String
            switch self {
            case .default: name =  "NewItem"//"Default"
            case .one: name = "NewItem" //"One"
            case .two: name = "NewItem"//"Two"
            case .three: name = "NewItem"
            }
            return name
        }
        
        var image: UIImage? {
            let imageName: String
            switch self {
            case .default:
                imageName = "Checkbox-Checked" // "default"
            case .one:
                imageName = "Checkbox-Checked" //"one"
            case .two:
                imageName = "Checkbox-Checked" //"two"
            case .three:
                imageName = "Checkbox-Checked" //"three"
            }
            return UIImage(named: imageName)
        }
        
        var nextViewController: UIViewController {
            let next: UIViewController
            switch self {
            case .default: // NewItem
                next =  UINavigationController(rootViewController: SheetViewController()) // MYViewController()
            case .one: // NewProject
                next = UINavigationController(rootViewController: SheetViewController()) // TagTimeViewController()
            case .two: // NewTagTime
                next = UINavigationController(rootViewController: SheetViewController())
            case .three:
                next = SheetViewController() //UINavigationController(rootViewController: NewItemVersionTwoViewController())//MYViewController() // 注意是没有被Nav包含的
            }
            return next
        }
    }
}

// - 没效果
extension UITableViewCell {
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let superPoint = self.convert(point, to: superview)
        let pt = layer.presentation()?.convert(superPoint, from: superview!.layer)
        return super.hitTest(pt!, with: event)
    }
}
