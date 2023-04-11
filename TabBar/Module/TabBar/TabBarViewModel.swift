//
//  TabBarViewModel.swift
//  TabBar
//
//  Created by Ajay Choudhary on 10/04/23.
//

import UIKit

class TabBarViewModel: RootNavigationViewModel {
    weak var controller: RootNavigationController?
    
    var selectedIndex: Int = 0 {
        didSet {
            controller?.selectIndex(at: selectedIndex)
        }
    }
    
    var items: [RootNavigationItem] {
        didSet {
            controller?.applyModel()
        }
    }
    
    var viewControllers: [UIViewController]? {
        didSet {
            controller?.applyModel()
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
