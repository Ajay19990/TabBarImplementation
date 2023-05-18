//
//  TabBarController.swift
//  TabBar
//
//  Created by Ajay Choudhary on 10/04/23.
//

import UIKit

class TabBarController:
    UIViewController,
    RootNavigationController,
    RootNavigationItemViewModelDelegate {
    var viewModel: RootNavigationViewModel

    private var controllers = [UIViewController]()
    private var viewModels: [RootNavigationItemViewModel] = []
    
    init(viewModel: RootNavigationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutSubViews()
        layoutConstraints()
        setupChildControllers()
        applyModel()
    }
    
    func applyModel() {
        removeAllSubViews(from: mainStackView)
        removeAllSubViews(from: tabBarItemStackView)
        removeAllControllers()
        
        setupChildControllers()
        selectIndex(at: viewModel.selectedIndex)
    }
    
    private func removeAllSubViews(from stackView: UIStackView) {
        for view in stackView.arrangedSubviews {
            mainStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    private func removeAllControllers() {
        for item in viewModel.items {
            let viewController = viewModel.viewControllers?[guarded: item.viewModel.index]
            viewController?.removeFromParent()
        }
        controllers = []
    }
    
    private func setupChildControllers() {
        for (index, item) in viewModel.items.enumerated() {
            if let viewController = viewModel.viewControllers?[guarded: item.viewModel.index] {
                mainStackView.addArrangedSubview(viewController.view)
                controllers.append(viewController)
            }
            
            item.viewModel.delegate = self
            item.viewModel.index = index
            item.viewModel.itemViewActions = item
            tabBarItemStackView.addArrangedSubview(item)
        }
    }
    
    func selectIndex(at index: Int) {
        guard index >= 0 && index < controllers.count else { return }
        let viewController = controllers[index]
        removeChildren()
        addChild(viewController)
        mainStackView.arrangedSubviews.forEach { $0.isHidden = $0 != viewController.view }
    }
    
    func removeChildren() {
        for childViewController in children {
            childViewController.removeFromParent()
        }
    }
    
    // MARK: - RootNavigationItemViewModelDelegate
    
    func didSelect(viewModel: RootNavigationItemViewModel) {
        self.viewModel.selectedIndex = viewModel.index
        self.viewModel.items.forEach { item in
            item.viewModel.isSelected = (item.viewModel.index == viewModel.index)
        }
    }
    
    func hideTabBar() {
        
    }
    
    func showTabBar() {
        
    }
    
    // MARK: - SetupUI
    
    private func layoutSubViews() {
        view.addSubview(mainStackView)
        view.addSubview(tabBarItemStackView)
    }
    
    private func layoutConstraints() {
        NSLayoutConstraint.activate([
            tabBarItemStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarItemStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarItemStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBarItemStackView.heightAnchor.constraint(equalToConstant: 65),
            
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: tabBarItemStackView.topAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    // MARK: - Views
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let tabBarItemStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
}


extension Array {
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        return self[idx]
    }
}
