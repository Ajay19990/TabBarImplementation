//
//  RootNavigationItem.swift
//  TabBar
//
//  Created by Ajay Choudhary on 09/05/23.
//

import UIKit

protocol RootNavigationItemViewModelDelegate {
    func didSelect(viewModel: RootNavigationItemViewModel)
}

protocol RootNavigationItemViewModel: AnyObject {
    var index: Int { get set }
    var title: String { get set }
    var image: UIImage? { get set }
    var isSelected: Bool? { get set }
    var itemViewActions: RootNavigationItemActions? { get set }

    var delegate: RootNavigationItemViewModelDelegate? { get set }
    var selectedImage: UIImage? { get set }
    var animationURL: URL? { get set }
}

protocol RootNavigationItem: RootNavigationItemActions, UIView {
    var viewModel: RootNavigationItemViewModel { get }
}

protocol RootNavigationItemActions: AnyObject {
    func applyModel()
}
