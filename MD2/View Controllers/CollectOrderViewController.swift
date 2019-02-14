//
//  CollectOrderViewController.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class CollectOrderViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    private var originalBrightness = CGFloat(0) // brightness of screen when view is loaded
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // increase brightness for easy scanning
        // something FirstBus does so figured we should do it too
        originalBrightness = UIScreen.main.brightness
        UIScreen.main.brightness = 1
        
        self.title = "Collect!"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // reset screen to original brightness level
        UIScreen.main.brightness = originalBrightness
    }

    @IBAction func returnButton_touchUpInside(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
