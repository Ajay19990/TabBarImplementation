//
//  TabBarViewModel.swift
//  TabBar
//
//  Created by Ajay Choudhary on 10/04/23.
//

import Foundation

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
    
    init(items: [RootNavigationItem]) {
        self.items = items
    }
}
