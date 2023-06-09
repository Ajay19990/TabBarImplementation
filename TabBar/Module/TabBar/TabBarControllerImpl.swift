//
//  TabBarController.swift
//  TabBar
//
//  Created by Ajay Choudhary on 10/04/23.
//

import UIKit

class TabBarControllerImpl:
    UIViewController,
    RootNavigationControllerActions,
    RootNavigationItemViewModelDelegate {
    var isMenuBarHidden: Bool?
    
    var viewModel: RootNavigationViewModel

    private var controllers = [UIViewController]()
    private var viewModels: [RootNavigationItemViewModel] = []
    var delegate: RootNavigationDelegate?
    
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
        applyModel()
    }
    
    func applyModel() {
        removeAllSubViews(from: controllerStackView)
        removeAllSubViews(from: tabBarItemStackView)
        removeAllControllers()
        
        setupChildControllers()
        selectIndex(at: viewModel.selectedIndex)
    }
    
    private func removeAllSubViews(from stackView: UIStackView) {
        for view in stackView.arrangedSubviews {
            controllerStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    private func removeAllControllers() {
        for itemViewModel in viewModel.itemViewModels {
            let viewController = viewModel.viewControllers?[guarded: itemViewModel.index]
            viewController?.removeFromParent()
        }
        controllers = []
    }
    
    private func setupChildControllers() {
        for (index, itemViewModel) in viewModel.itemViewModels.enumerated() {
            if let viewController = viewModel.viewControllers?[guarded: itemViewModel.index] {
                controllerStackView.addArrangedSubview(viewController.view)
                controllers.append(viewController)
            }
            
            itemViewModel.delegate = self
            itemViewModel.index = index
            
            let itemView = TabBarItemView(viewModel: itemViewModel)
            itemViewModel.itemViewActions = itemView
            tabBarItemStackView.addArrangedSubview(itemView)
        }
    }
    
    func selectIndex(at index: Int) {
        guard index >= 0 && index < controllers.count else { return }
        let viewController = controllers[index]
        
        delegate?.rootNavigationController(self, didSelect: viewController)
        removeChildren()
        addChild(viewController)
        controllerStackView.arrangedSubviews.forEach { $0.isHidden = $0 != viewController.view }

        updateIsSelectedForTabBarItems()
    }
    
    func updateIsSelectedForTabBarItems() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.viewModel.itemViewModels.forEach { itemViewModel in
                itemViewModel.isSelected = (itemViewModel.index == self.viewModel.selectedIndex)
            }
        }
    }
    
    func removeChildren() {
        for childViewController in children {
            childViewController.removeFromParent()
        }
    }
    
    // MARK: - RootNavigationItemViewModelDelegate
    
    func didSelect(viewModel: RootNavigationItemViewModel) {
        self.viewModel.itemViewModels.forEach { itemViewModel in
            itemViewModel.isSelected = (itemViewModel.index == viewModel.index)
        }
        self.viewModel.selectedIndex = viewModel.index
    }
    
    func shouldSelect(viewModel: RootNavigationItemViewModel) -> Bool {
        delegate?.rootNavigationController(self, shouldSelect: self.viewModel.viewControllers?[viewModel.index]) ?? true
    }
    
    func hideMenuBar() {
        UIView.animate(withDuration: 0.2) {
            self.tabBarItemStackView.isHidden = true
            self.mainStackView.layoutIfNeeded()
        }
    }
    
    func showMenuBar() {
        UIView.animate(withDuration: 0.2) {
            self.tabBarItemStackView.isHidden = false
            self.mainStackView.layoutIfNeeded()
        }
    }
    
    // MARK: - SetupUI
    
    private func layoutSubViews() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(controllerStackView)
        mainStackView.addArrangedSubview(tabBarItemStackView)
    }
    
    private func layoutConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Views
    
    private let controllerStackView: UIStackView = {
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
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
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
