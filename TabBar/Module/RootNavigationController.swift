//
//  RootNavigationController.swift
//  TabBar
//
//  Created by Ajay Choudhary on 04/04/23.
//

import UIKit

protocol RootNavigationViewModel {
    var controllerActions: RootNavigationControllerActions? { get set }
    var selectedIndex: Int { get set }
    var items: [RootNavigationItem] { get set }
    var viewControllers: [UIViewController]? { get set }
}

protocol RootNavigationController: RootNavigationControllerActions, UIViewController {
    var viewModel: RootNavigationViewModel { get }
}

protocol RootNavigationControllerActions: AnyObject {
    func applyModel()
    func selectIndex(at index: Int)
}
