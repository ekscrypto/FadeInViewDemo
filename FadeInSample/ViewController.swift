//
//  ViewController.swift
//  FadeInSample
//
//  Created by Dave Poirier on 2023-04-08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showModal(_: UIButton) {
        let fadedInViewController = FadedInViewController()
        fadedInViewController.modalPresentationStyle = .overFullScreen
        
        // Because the FadedInViewController has it's own animation, we ask the
        // modal presentation to not be animated.
        present(fadedInViewController, animated: false)
    }

}

