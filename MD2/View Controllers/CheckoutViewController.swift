//
//  CheckoutViewController.swift
//  MD2
//
//  Created by Will Taylor on 06/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {

    /// rest ID = CheckoutViewController
    
    // MARK: - @IBOutlets
    @IBOutlet var itemImageViews: [UIImageView]!
    @IBOutlet var itemImageLabels: [UILabel]!
    
    var mealDeal: MealDeal!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.largeTitleDisplayMode = .always
        
        // main
        itemImageViews[0].image = UIImage(named: "Main")
        itemImageLabels[0].text = mealDeal.main?.name
        
        // snack
        itemImageViews[1].image = UIImage(named: "Snack")
        itemImageLabels[1].text = mealDeal.snack?.name
        
        // drink
        itemImageViews[2].image = UIImage(named: "Drink")
        itemImageLabels[2].text = mealDeal.drink?.name
        
    }
    
    @IBAction func orderButton_touchUpInside(_ sender: Any) {
        showErrorAlert(title: "Order Placed!", message: "Your order has been placed successfully.")
    }
    
    

}
