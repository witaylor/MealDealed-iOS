//
//  HomeViewController.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
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
    
    @IBOutlet var timeLeftLabel: UILabel!
    @IBOutlet var closingTimeLabel: UILabel!
    
    private var timer: CountdownTimer?
    
    
    private var previousOrder: Order? // nil if user doesn't have a recent order
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        checkRecentOrder()
        setTimer()
        
        timeLeftLabel.text? = "12:00" // TODO: - get time left until order limit
        closingTimeLabel.text = closingTimeLabel.text?.replacingOccurrences(of: "_TIME_", with: "10") // get fresh closing time
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkRecentOrder()
        setTimer()
    }
    
    private func setTimer() {
        timeLeftLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeLeftLabel.font.pointSize, weight: .regular)
        self.timer = CountdownTimer(label: timeLeftLabel)
    }
 
    private func setPreviousOrderGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(recentOrderStackViewTapped))
        recentOrderStackView.addGestureRecognizer(tapGesture)
    }
    
    @objc func recentOrderStackViewTapped() {
        if let mealDeal = self.previousOrder?.getMealDeal() {
            coordinator?.checkout(withMeal: mealDeal)
        } else {
            showErrorAlert(title: "Oops!", message: "I'm sorry! Something seems to have gone wrong, please try again.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkRecentOrder()
    }
    
    private func checkRecentOrder() {
        if let loaded = coordinator?.orderManager?.hasLoadedOrders(), loaded {
            // orders have finished loading
            loadRecentOrder()
        } else {
            // wait .5 seconds and try again
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.checkRecentOrder()
            }
        }
    }
    
    private func loadRecentOrder() {
        if let prevOrder = coordinator?.orderManager?.getLastOrder() {
            self.previousOrder = prevOrder
            
            setPreviousOrderViews()
            setPreviousOrderGesture()
            setMealLabels(order: prevOrder)
        }
    }
    
    private func setPreviousOrderViews() {
        if (previousOrder?.readyForCollection)! {
            enableButton(collectOrderButton)
        }
//        enableButton(collectOrderButton)
        enableButton(reorderButton)
        
        noRecentOrderLabel.isHidden = true    // hide label
        recentOrderStackView.isHidden = false // and show stack view
    }
    
    private func setMealLabels(order: Order) {
        mainLabel.text  = order.getItem(inCatagory: .Main)?.name  ?? "error"
        snackLabel.text = order.getItem(inCatagory: .Snack)?.name ?? "error"
        drinkLabel.text = order.getItem(inCatagory: .Drink)?.name ?? "error"
    }
    
    private func setMealImages(order: Order) {
        mainImageView.image  = UIImage(named: "Main")
        snackImageView.image = UIImage(named: "Snack")
        drinkImageView.image = UIImage(named: "Drink")
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
    @IBAction func reorderButton_touchUpInside(_ sender: Any) {
        // if going from home then the device is connected
        coordinator?.viewPreviousOrders()
    }
}
