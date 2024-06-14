//
//  ViewController.swift
//  DemoForInteractionDuringTransition
//
//  Created by Junkai Zheng on 2024/6/13.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    var newOptionsMenuVC: MenuViewController? // NewOptionsMenuViewController? // contextMenu 的菜单
    
    lazy var plusButton: AddButton = { // PlusButton
        let button = AddButton()
        button.addAction { [weak self] in
            self?.openCreationMenu()
        }
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "HomeView"
        
        view.addSubview(plusButton)
        plusButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.size.equalTo(55)
        }
    }


}

extension HomeViewController {
    @objc func openCreationMenu() {
//        if newOptionsMenuVC == nil {
//            newOptionsMenuVC = NewOptionsMenuViewController()
//            newOptionsMenuVC?.dismissAndShowDelegate = self
//        }
        if newOptionsMenuVC == nil {
            newOptionsMenuVC = MenuViewController()
            newOptionsMenuVC?.view.isUserInteractionEnabled = true
            newOptionsMenuVC?.delegate = self
        }
        
        ContextMenu.shared.show(
            sourceViewController: self,
            viewController: newOptionsMenuVC!,
            options: ContextMenu.Options(
                containerStyle: ContextMenu.ContainerStyle(
                    cornerRadius: 12,
                    xPadding: -(plusButton.bounds.width/2), yPadding: 6, backgroundColor: UIColor(red: 41/255.0, green: 45/255.0, blue: 53/255.0, alpha: 1)
                ),
                menuStyle: .minimal, // 不要.default。要去掉navbar
                hapticsStyle: .none
            ),
            sourceView: plusButton,
            delegate: self
        )

    }
}

extension HomeViewController: ContextMenuDelegate {
    func contextMenuWillDismiss(viewController: UIViewController, animated: Bool) {
//        self.nameLabel.text = "Dismiss modal"
    }
    
    func contextMenuDidDismiss(viewController: UIViewController, animated: Bool) {
    }
}

extension HomeViewController: DismissContextMenuAndPrensentNextVCDelegate {
    
    // present ViewController
    func didTapCloseAndPresentNext(toViewController: UIViewController?) {
        guard let toVC = toViewController else { return }
        present(toVC, animated: true, completion: nil)
    }
    
}

