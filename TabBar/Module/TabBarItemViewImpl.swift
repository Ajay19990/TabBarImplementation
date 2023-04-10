//
//  TabBarItemViewImpl.swift
//  LazyPay
//
//  Created by Ajay Choudhary on 04/04/23.
//  Copyright © 2023 PayU Finance Private Limited. All rights reserved.
//

import UIKit

class TabBarItemViewModel: RootNavigationItemViewModel {
    var delegate: RootNavigationItemViewModelDelegate?
    var title: String
    var icon: UIImage?
    var controller: UIViewController
    var index: Int
    var selectedColor: UIColor = .systemPink
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
        index: Int
    ) {
        self.title = title
        self.icon = icon
        self.controller = controller
        self.index = index
        self.isSelected = false
    }
}

class TabBarItemView: UIView, RootNavigationItem {
    var viewModel: RootNavigationItemViewModel
    
    init(viewModel: RootNavigationItemViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
    }
    
    private func setupView() {
        layoutSubViews()
        layoutConstraints()
        setTapGesture()
        applyModel()
    }
    
    func applyModel() {
        setImage()
        setLabel()
    }
    
    private func setImage() {
        if viewModel.isSelected ?? false {
            imageView.image = viewModel.icon?.withTintColor(viewModel.selectedColor)
        } else {
            imageView.image = viewModel.icon
        }
    }
    
    private func setLabel() {
        label.text = viewModel.title
        label.textColor = viewModel.isSelected == true ? .systemPink : .label
    }
    
    private func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    private func layoutSubViews() {
        addSubview(imageView)
        addSubview(label)
    }
    
    private func layoutConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTap() {
        viewModel.delegate?.didSelect(viewModel: viewModel)
    }
    
    // MARK: - Views
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
