//
//  RootNavigationController.swift
//  TabBar
//
//  Created by Ajay Choudhary on 04/04/23.
//

import UIKit

protocol RootNavigationDelegate {
    func rootNavigationController(_ rootNavigationController: RootNavController, shouldSelect viewController: UIViewController?) -> Bool
    func rootNavigationController(_ rootNavigationController: RootNavController, didSelect viewController: UIViewController?)
}

protocol RootNavigationViewModel {
    var controllerActions: RootNavigationControllerActions? { get set }
    var selectedIndex: Int { get set }
    var items: [RootNavigationItem] { get set }
    var viewControllers: [UIViewController]? { get set }
}

protocol RootNavController: RootNavigationControllerActions, UIViewController {
    var viewModel: RootNavigationViewModel { get }
    var delegate: RootNavigationDelegate? { get set }
    
    var isMenuBarHidden: Bool? { get set }
    func hideMenuBar()
    func showMenuBar()
}

protocol RootNavigationControllerActions: AnyObject {
    func applyModel()
    func selectIndex(at index: Int)
}
