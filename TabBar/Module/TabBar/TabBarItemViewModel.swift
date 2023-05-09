//
//  TabBarItemViewModel.swift
//  TabBar
//
//  Created by Ajay Choudhary on 10/04/23.
//

import UIKit

class TabBarItemViewModel: RootNavigationItemViewModel {
    var delegate: RootNavigationItemViewModelDelegate?
    var title: String
    var icon: UIImage?
    var index: Int
    var selectedColor: UIColor
    var animationURL: URL? {
        didSet {
            let itemViewActions = itemViewActions as? TabBarItemView
            itemViewActions?.setAnimationView()
        }
    }
    
    weak var itemViewActions: RootNavigationItemActions?
    
    var isSelected: Bool? {
        didSet {
            itemViewActions?.applyModel()
        }
    }
    
    init(
        title: String,
        icon: UIImage? = nil,
        index: Int,
        animationURL: URL? = nil,
        selectedColor: UIColor? = nil,
        isSelected: Bool? = nil
    ) {
        self.title = title
        self.icon = icon
        self.index = index
        self.isSelected = false
        self.animationURL = animationURL
        self.selectedColor = selectedColor ?? .systemPink
        self.isSelected = isSelected
    }
}
