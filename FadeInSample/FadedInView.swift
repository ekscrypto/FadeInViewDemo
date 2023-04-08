//
//  FadedInView.swift
//  FadeInSample
//
//  Created by Dave Poirier on 2023-04-08.
//

import UIKit

class FadedInView: UIView {
    
    // MARK: - Subviews
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Hi! I'm modally presented with a custom fade-in animation"
        label.numberOfLines = 2
        label.lineBreakMode  = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(primaryAction: .init(handler: { [weak self] _ in
            // When we want to dismiss the view, instead of calling the ViewController's
            // .dismiss(animated:) we call our custom fadeOut() animation.  Once
            // the animation completes the "afterFadeOutAction" closure will be executed
            // which will allow the ViewController to dismiss itself.
            self?.fadeOut()
        }))
        button.setTitle("Dismiss", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        backgroundColor = .black.withAlphaComponent(0.9)
        alpha = 0.0 // Start invisible, see fadeIn() and fadeOut() below
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    func afterFadeOut(_ action: @escaping () -> Void) -> Self {
        afterFadeOutAction = action
        return self
    }
    
    private var afterFadeOutAction: () -> Void = { /* action to be set by ViewController */ }
    
    // MARK: - Fade In / Fade Out
    
    private let fadeAnimationDuration: TimeInterval = 0.3 // UIKit animations are roughly 300ms
    func fadeIn() {
        UIView.animate(
            withDuration: fadeAnimationDuration,
            animations: {
                self.alpha = 1.0 //
            })
    }
    
    func fadeOut() {
        UIView.animate(
            withDuration: fadeAnimationDuration,
            animations: {
                self.alpha = 0.0 // means the view will no longer be visible
            },
            completion: { _ in
                self.afterFadeOutAction()
            })
    }


    // MARK: - Layout management
    override func layoutSubviews() {
        if label.superview == nil {
            setupLayout()
        }
        super.layoutSubviews()
    }
    
    private func setupLayout() {
        addSubview(label)
        addSubview(dismissButton)
        addConstraints([
            label.centerXAnchor.constraint(
                equalTo: centerXAnchor),
            label.centerYAnchor.constraint(
                equalTo: centerYAnchor),
            label.leadingAnchor.constraint(
                greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor),
            label.bottomAnchor.constraint(
                equalTo: dismissButton.topAnchor,
                constant: -30),
            dismissButton.centerXAnchor.constraint(
                equalTo: label.centerXAnchor)
        ])
    }
}
