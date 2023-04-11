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
            let itemView = itemView as? TabBarItemView
            itemView?.setAnimationView()
        }
    }
    
    weak var itemView: RootNavigationItem?
    
    var isSelected: Bool? {
        didSet {
            itemView?.applyModel()
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
