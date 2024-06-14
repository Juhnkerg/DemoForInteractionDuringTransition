//
//  NewTagTimeViewController.swift
//  DemoForInteractionDuringTransition
//
//  Created by Junkai Zheng on 2024/5/21.
//

import UIKit

class SheetViewController: UIViewController {
    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .lightGray.withAlphaComponent(0.6)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Detail"
        
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([

            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80)
        ])
    }

}


