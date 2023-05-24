//
//  ViewController.swift
//  TabBar
//
//  Created by Ajay Choudhary on 04/04/23.
//

import UIKit
import StoreKit

class ViewControllerOne: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupButton()
    }
    
    func setupButton() {
        let button = UIButton(type: .system)
        button.setTitle("Center Button", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    @objc func tapped() {
        navigationController?.pushViewController(
            NestedViewControllerOne(),
            animated: true
        )
    }
}

class ViewControllerTwo: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

class NestedViewControllerOne: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButton()
    }
    
    func setupButton() {
        let button = UIButton(type: .system)
        button.setTitle("Center Button", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }
    
    @objc func tapped() {
        navigationController?.pushViewController(
            NestedViewControllerTwo(),
            animated: true
        )
    }
}

class NestedViewControllerTwo: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        let viewController = navigationController?.viewControllers.first
        if let tabBarController = navigationController?.parent as? RootNavController {
            tabBarController.hideMenuBar()
        }
    }
    
    func findViewController(ofType viewControllerType: UIViewController.Type) -> UIViewController? {
        if let navigationController = self.navigationController {
            // Iterate through the view controllers in the navigation stack
            for viewController in navigationController.viewControllers {
                if viewController.isKind(of: viewControllerType) {
                    return viewController
                }
            }
        }
        
        return nil
    }
}
