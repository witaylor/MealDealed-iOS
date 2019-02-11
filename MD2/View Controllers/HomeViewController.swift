//
//  HomeViewController.swift
//  MD2
//
//  Created by Will Taylor on 01/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadTestData()
    }
    
    private func loadTestData() {
        if let lastOrder = OrderManager().getLastOrder() {
            enableButton(collectOrderButton)
            enableButton(reorderButton)
            
            noRecentOrderLabel.isHidden = true
            recentOrderStackView.isHidden = false
            
            mainLabel.text  = lastOrder.getItem(inCatagory: .Main)?.name  ?? "error"
            snackLabel.text = lastOrder.getItem(inCatagory: .Snack)?.name ?? "error"
            drinkLabel.text = lastOrder.getItem(inCatagory: .Drink)?.name ?? "error"
        }
    }
    
    private func enableButton(_ button: UIButton) {
        button.isEnabled = true
        button.backgroundColor = .red
    }
    
}
