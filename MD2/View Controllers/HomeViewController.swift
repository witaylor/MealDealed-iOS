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
    
    // Recent Order Views
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
    
    private var previousOrder: Order? // nil if user doesn't have a recent order
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkRecentOrder()
    }
    
    private func checkRecentOrder() {
        if let prevOrder = coordinator?.orderManager.getLastOrder(), prevOrder.isFull() {
            self.previousOrder = prevOrder
            
            setPreviousOrderViews()
            setMealLabels(order: prevOrder)
        }
    }
    
    private func setPreviousOrderViews() {
        enableButton(collectOrderButton)
        enableButton(reorderButton)
        
        noRecentOrderLabel.isHidden = true    // hide label
        recentOrderStackView.isHidden = false // and show stack view
    }
    
    private func setMealLabels(order: Order) {
        mainLabel.text  = order.getItem(inCatagory: .Main)?.name  ?? "error"
        snackLabel.text = order.getItem(inCatagory: .Snack)?.name ?? "error"
        drinkLabel.text = order.getItem(inCatagory: .Drink)?.name ?? "error"
    }
    
    private func enableButton(_ button: UIButton) {
        button.isEnabled = true
        button.alpha = 1
    }
    
    // MARK: - @IBActions
    
    @IBAction func newOrderButton_touchUpInside(_ sender: Any) {
        self.coordinator?.startNewOrder()
    }
    
    @IBAction func collectOrderButton_touchUpInside(_ sender: Any) {
        if let order = self.previousOrder {
            coordinator?.collect(order: order)
        }
    }
}
