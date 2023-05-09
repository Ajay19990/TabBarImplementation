//
//  TabBarItemViewImpl.swift
//  LazyPay
//
//  Created by Ajay Choudhary on 04/04/23.
//  Copyright © 2023 PayU Finance Private Limited. All rights reserved.
//

import UIKit
import Lottie

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
        setAnimationView()
        setHidden()
    }
    
    private func setHidden() {
        if animationView == nil || (viewModel.image == nil && viewModel.selectedImage == nil) { return }
        if let isSelected = viewModel.isSelected {
            imageView.isHidden = isSelected
            animationView?.isHidden = !isSelected
        }
    }
    
    private func setImage() {
        if let selectedImage = viewModel.selectedImage, viewModel.isSelected ?? false {
            imageView.image = selectedImage
        } else if viewModel.isSelected == false && viewModel.image == nil && viewModel.selectedImage != nil {
            imageView.image = viewModel.selectedImage
        } else {
            imageView.image = viewModel.image
        }
        
        if viewModel.isSelected == true && viewModel.selectedImage == nil {
            viewModel.selectedImage = viewModel.image
        }
    }
    
    private func setLabel() {
        label.text = viewModel.title
        label.textColor = viewModel.isSelected == true ? .systemPink : .label
    }
    
    func setAnimationView() {
        addAnimationViewAsSubView()
        layoutAnimationViewConstraints()
        playAnimation()
    }
    
    private func playAnimation() {
        if let animationView = animationView {
            if viewModel.isSelected ?? false {
                animationView.play()
            } else {
                animationView.stop()
            }
        }
    }
    
    private func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    private func layoutSubViews() {
        addSubview(imageView)
        addSubview(label)
        addAnimationViewAsSubView()
    }
    
    private func addAnimationViewAsSubView() {
        animationView?.removeFromSuperview()
        animationView = nil
        if let animationUrl = viewModel.animationURL {
            let animationView = LottieAnimationView(url: animationUrl) { [weak self] _ in
                self?.playAnimation()
            }
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.translatesAutoresizingMaskIntoConstraints = false
            self.animationView = animationView
            addSubview(animationView)
        }
    }
    
    private func layoutConstraints() {
        layoutImageViewConstraints()
        layoutLabelConstraints()
        layoutAnimationViewConstraints()
    }
    
    private func layoutImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func layoutLabelConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
        ])
    }
    
    private func layoutAnimationViewConstraints() {
        if let animationView = self.animationView {
            NSLayoutConstraint.activate([
                animationView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
                animationView.widthAnchor.constraint(equalToConstant: 30),
                animationView.heightAnchor.constraint(equalToConstant: 30)
            ])
        }
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
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private var animationView: LottieAnimationView?
}
