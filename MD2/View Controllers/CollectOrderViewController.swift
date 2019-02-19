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
    
    @IBOutlet private var qrCodeImageView: UIImageView!
    @IBOutlet private var uniUsernameLabel: UILabel!
    
    @IBOutlet private var mainLabel: UILabel!
    @IBOutlet private var snackLabel: UILabel!
    @IBOutlet private var drinkLabel: UILabel!
    
    private var originalBrightness = CGFloat(0) // brightness of screen when view is loaded
    
    var orderToCollect: Order!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // increase brightness for easy scanning
        originalBrightness = UIScreen.main.brightness
        UIScreen.main.brightness = 1
        
        self.title = "Collect"
        navigationItem.largeTitleDisplayMode = .always
        
        qrCodeImageView.image = orderToCollect.qrCode
        
        uniUsernameLabel.text = coordinator?.userManager.getCurrentUser()?.uniUsername
        
        mainLabel.text  = orderToCollect.getItem(inCatagory: .Main)?.name
        snackLabel.text = orderToCollect.getItem(inCatagory: .Snack)?.name
        drinkLabel.text = orderToCollect.getItem(inCatagory: .Drink)?.name
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // reset screen to original brightness level
        UIScreen.main.brightness = originalBrightness
    }

    @IBAction func returnButton_touchUpInside(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
