//
//  HomeViewController.swift
//  MD2
//
//  Created by Will Taylor on 01/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    // MARK: - @IBOutlets
    @IBOutlet var collectOrderButton: RoundedButton!
    @IBOutlet var reorderButton: RoundedButton!
    
    @IBOutlet var noRecentOrderLabel: UILabel!
    
    @IBOutlet var recentOrderStackView: UIStackView!
    
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var mainLabel: UILabel!
    
    @IBOutlet var snackView: UIView!
    @IBOutlet var snackImageView: UIImageView!
    @IBOutlet var snackLabel: UILabel!
    
    @IBOutlet var drinkView: UIView!
    @IBOutlet var drinkImageView: UIImageView!
    @IBOutlet var drinkLabel: UILabel!
    
    private var previousOrder: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkRecentOrder()
    }
    
    private func checkRecentOrder() {
        if let prevOrder = coordinator?.orderManager.getLastOrder(), prevOrder.isFull() {
            self.previousOrder = prevOrder
            
            enableButton(collectOrderButton)
            enableButton(reorderButton)
            
            noRecentOrderLabel.isHidden = true
            recentOrderStackView.isHidden = false
            
            mainLabel.text  = prevOrder.getItem(inCatagory: .Main)?.name  ?? "error"
            snackLabel.text = prevOrder.getItem(inCatagory: .Snack)?.name ?? "error"
            drinkLabel.text = prevOrder.getItem(inCatagory: .Drink)?.name ?? "error"
        }
    }
    
    private func enableButton(_ button: UIButton) {
        button.isEnabled = true
        button.alpha = 1
    }
    
    @IBAction func newOrderButton_touchUpInside(_ sender: Any) {
        self.coordinator?.startNewOrder()
    }
    
    @IBAction func collectOrderButton_touchUpInside(_ sender: Any) {
        if let order = self.previousOrder {
            coordinator?.collect(order: order)
        }
    }
    
    
}
