//
//  RootNavigationControllerImpl.swift
//  TabBar
//
//  Created by Ajay Choudhary on 04/04/23.
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
    
    init(items: [RootNavigationItem]) {
        self.items = items
    }
}

class TabBarController: UIViewController, RootNavigationController, RootNavigationItemViewModelDelegate {
    var viewModel: RootNavigationViewModel

    private var childControllers = [UIViewController]()
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
            let viewController = item.viewModel.controller
            viewController.removeFromParent()
        }
        childControllers = []
    }
    
    private func setupChildControllers() {
        for (index, item) in viewModel.items.enumerated() {
            let viewController = item.viewModel.controller
            mainStackView.addArrangedSubview(viewController.view)
            addChild(viewController)
            childControllers.append(viewController)
            
            item.viewModel.delegate = self
            item.viewModel.index = index
            item.viewModel.itemView = item
            tabBarItemStackView.addArrangedSubview(item)
        }
    }
    
    func selectIndex(at index: Int) {
        guard index >= 0 && index < childControllers.count else { return }
        let viewController = childControllers[index]
        mainStackView.arrangedSubviews.forEach { $0.isHidden = $0 != viewController.view }
    }
    
    // MARK: - RootNavigationItemViewModelDelegate
    
    func didSelect(viewModel: RootNavigationItemViewModel) {
        self.viewModel.selectedIndex = viewModel.index
        self.viewModel.items.forEach { item in
            item.viewModel.isSelected = (item.viewModel.index == viewModel.index)
        }
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
