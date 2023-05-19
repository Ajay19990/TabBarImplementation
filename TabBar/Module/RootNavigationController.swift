//
//  RootNavigationController.swift
//  TabBar
//
//  Created by Ajay Choudhary on 04/04/23.
//

import UIKit

protocol RootTabBarDelegate {
    func tabBarController(_ tabBarController: RootTabBarController, shouldSelect viewController: UIViewController?) -> Bool
    func tabBarController(_ tabBarController: RootTabBarController, didSelect viewController: UIViewController?)
}

protocol RootNavigationViewModel {
    var controllerActions: RootNavigationControllerActions? { get set }
    var selectedIndex: Int { get set }
    var items: [RootNavigationItem] { get set }
    var viewControllers: [UIViewController]? { get set }
}

protocol RootTabBarController: UIViewController, RootNavigationController {
    var delegate: RootTabBarDelegate? { get set }
    
    var isTabBarHidden: Bool? { get set }
    func hideTabBar()
    func showTabBar()
}

protocol RootNavigationController: RootNavigationControllerActions, UIViewController {
    var viewModel: RootNavigationViewModel { get }
}

protocol RootNavigationControllerActions: AnyObject {
    func applyModel()
    func selectIndex(at index: Int)
}
