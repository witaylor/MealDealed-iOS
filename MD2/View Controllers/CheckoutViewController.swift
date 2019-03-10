//
//  CheckoutViewController.swift
//  MD2
//
//  Created by Will Taylor on 06/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    // MARK: - @IBOutlets
    @IBOutlet var itemImageViews: [UIImageView]!
    @IBOutlet var itemImageLabels: [UILabel]!
    
    var mealDeal: MealDeal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setOrderLabels()
        setOrderImages()
        
        navigationItem.hidesBackButton       = true // prevent going back to order selection
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setOrderLabels() {
        itemImageLabels[0].text = mealDeal.main?.name
        itemImageLabels[1].text = mealDeal.snack?.name
        itemImageLabels[2].text = mealDeal.drink?.name
    }
    
    private func setOrderImages() {
        itemImageViews[0].image = UIImage(named: "Main")
        itemImageViews[1].image = UIImage(named: "Snack")
        itemImageViews[2].image = UIImage(named: "Drink")
    }
    
    @IBAction func orderButton_touchUpInside(_ sender: Any) {
        let newOrder = Order(forCustomer: (coordinator?.userManager.getCurrentUser())!, withMealDeal: mealDeal)
        coordinator?.orderManager?.placeOrder(newOrder)
        showOrderPlacedAlert(forOrder: newOrder)
    }
    
    private func showOrderPlacedAlert(forOrder order: Order) {
        let alert = UIAlertController(title: "Order Placed!", message: "Your order has been placed successfully.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Return", style: .default, handler: { (action) in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Collect Now", style: .default, handler: { (action) in
            self.coordinator?.collect(order: order)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelButton_touchUpInside(_ sender: Any) {
        let alert = createErrorAlert(title: "Are you sure?", message: "Are you sure you would like to canel your order? It will not be saved.")
        
        alert.addAction(UIAlertAction(title: "I'm Sure!", style: .destructive, handler: { (action) in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        present(alert, animated: true)
    }
}
