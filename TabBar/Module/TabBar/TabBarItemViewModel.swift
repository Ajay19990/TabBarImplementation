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
    var image: UIImage?
    var index: Int
    var selectedImage: UIImage?
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
        image: UIImage? = nil,
        index: Int,
        animationURL: URL? = nil,
        selectedImage: UIImage? = nil,
        isSelected: Bool? = nil
    ) {
        self.title = title
        self.image = image
        self.index = index
        self.isSelected = false
        self.animationURL = animationURL
        self.selectedImage = selectedImage
        self.isSelected = isSelected
    }
}
