//
//  TabBarViewModel.swift
//  TabBar
//
//  Created by Ajay Choudhary on 10/04/23.
//

import UIKit

class TabBarViewModel: RootNavigationViewModel {
    weak var controllerActions: RootNavigationControllerActions?
    
    var selectedIndex: Int = 0 {
        didSet {
            controllerActions?.selectIndex(at: selectedIndex)
        }
    }
    
    var itemViewModels: [RootNavigationItemViewModel] {
        didSet {
            controllerActions?.applyModel()
        }
    }
    
    var viewControllers: [UIViewController]? {
        didSet {
            controllerActions?.applyModel()
        }
    }
    
    init(
        itemViewModels: [RootNavigationItemViewModel],
        viewControllers: [UIViewController]? = nil
    ) {
        self.itemViewModels = itemViewModels
        self.viewControllers = viewControllers
    }
}
