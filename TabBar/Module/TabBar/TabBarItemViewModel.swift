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
    var controller: UIViewController
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
        controller: UIViewController,
        index: Int,
        animationURL: URL? = nil,
        selectedColor: UIColor? = nil
    ) {
        self.title = title
        self.icon = icon
        self.controller = controller
        self.index = index
        self.isSelected = false
        self.animationURL = animationURL
        self.selectedColor = selectedColor ?? .systemPink
    }
}
