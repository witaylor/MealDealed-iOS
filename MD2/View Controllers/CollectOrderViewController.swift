//
//  CollectOrderViewController.swift
//  MD2
//
//  Created by Will Taylor on 11/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class CollectOrderViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    private var originalBrightness = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        originalBrightness = UIScreen.main.brightness
        UIScreen.main.brightness = 1
        
        self.title = "Collect!"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIScreen.main.brightness = originalBrightness
    }

    @IBAction func returnButton_touchUpInside(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
