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
    
    var items: [RootNavigationItem] {
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
        items: [RootNavigationItem],
        viewControllers: [UIViewController]? = nil
    ) {
        self.items = items
        self.viewControllers = viewControllers
    }
}
