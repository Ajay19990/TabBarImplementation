//
//  RootNavigationItem.swift
//  TabBar
//
//  Created by Ajay Choudhary on 09/05/23.
//

import UIKit

protocol RootNavigationItemViewModelDelegate {
    func didSelect(viewModel: RootNavigationItemViewModel)
    func shouldSelect(viewModel: RootNavigationItemViewModel) -> Bool
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
    
    func shouldUseSelectedImage() -> Bool
    func shouldUseSelectedImageAsFallbackImage() -> Bool
}

protocol RootNavigationItem: UIView {
    var viewModel: RootNavigationItemViewModel { get }
    func setTextAttributes(_ attributes: [NSAttributedString.Key: Any])
}

protocol RootNavigationItemActions: RootNavigationItem, AnyObject {
    func applyModel()
}
