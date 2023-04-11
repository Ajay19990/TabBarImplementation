//
//  RootNavigationController.swift
//  TabBar
//
//  Created by Ajay Choudhary on 04/04/23.
//

import UIKit

protocol RootNavigationItemViewModelDelegate {
    func didSelect(viewModel: RootNavigationItemViewModel)
}

protocol RootNavigationItemViewModel: AnyObject {
    var index: Int { get set }
    var title: String { get set }
    var icon: UIImage? { get set }
    var isSelected: Bool? { get set }
    var itemView: RootNavigationItem? { get set }

    var delegate: RootNavigationItemViewModelDelegate? { get set }
    var selectedColor: UIColor { get set }
    var animationURL: URL? { get set }
}

protocol RootNavigationItem: AnyObject, UIView {
    var viewModel: RootNavigationItemViewModel { get }
    func applyModel()
}

//
protocol RootNavigationViewModel {
    var controller: RootNavigationController? { get set }
    var selectedIndex: Int { get set }
    var items: [RootNavigationItem] { get set }
    var viewControllers: [UIViewController]? { get set }
}

protocol RootNavigationController: AnyObject, UIViewController {
    var viewModel: RootNavigationViewModel { get }
    func applyModel()
    func selectIndex(at index: Int)
}
