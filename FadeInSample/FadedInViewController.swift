//
//  FadedInViewController.swift
//  FadeInSample
//
//  Created by Dave Poirier on 2023-04-08.
//

import UIKit

class FadedInViewController: UIViewController {
    
    private lazy var fadedInView = FadedInView()
        .afterFadeOut { [weak self] in
            // Once the view is done fading out, it is no longer visible so the
            // dismiss should not be animated
            self?.dismiss(animated: false)
        }

    // Use our custom view
    override func loadView() {
        view = fadedInView
    }
    
    // viewDidAppear is called immediately after the ViewController is modally presented
    // and we use this opportunity to trigger the fade-in animation.
    //
    // Note that we set the view.alpha to 0.0 in loadView, so the view will animate
    // from .alpha = 0.0 to .alpha = 1.0 when it first appears
    //
    // If the app is minimized with the modal screen presented and comes back again,
    // the animation will be triggered again but becase the .alpha value is already
    // 1.0, there will be no visible animation to the user.
    //
    // One could detect this and skip the UIView.animate call, but for our demonstration
    // purpose this should be sufficient.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fadedInView.fadeIn()
    }
}

