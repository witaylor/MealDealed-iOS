//
//  MainCoordinator.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    // Shared Managers
    var userManager  = UserManager()
    var orderManager = OrderManager()
    
    init(navController: UINavigationController) {
        DataManager.shared.loadItems() // begin loading items ASAP
        
        self.navigationController = navController
        setupNavBar()
        
        orderManager.loadOrders(forUser: userManager.getCurrentUser()!)
    }
    
    private func setupNavBar() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.barTintColor = UIColor(red: 246/255, green: 168/255, blue: 89/255, alpha: 1)
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func start() {
        let vc = HomeViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func start(login: Bool, animated: Bool) {
        if login {
            self.login(animated: animated)
        } else {
            let vc = HomeViewController.instantiate()
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: animated)
        }
    }
    
    private func login(animated: Bool) {
        let vc = LoginViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: animated)
    }
    
    // MARK: - Navigation Functions
    
    func startNewOrder() {
        // Check if items have loaded - maybe this check shouldn't be here??
        if DataManager.shared.getItems(catagory: .Main).count <= 0 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute: {
                self.goToNewOrder()
            })
        } else {
            self.goToNewOrder()
        }
    }
    
    private func goToNewOrder() {
        let vc = NewOrderViewController.instantiate()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func viewPreviousOrders() {
        let vc = PreviousOrdersViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func checkout(withMeal meal: MealDeal) {
        let vc = CheckoutViewController.instantiate()
        vc.coordinator = self
        vc.mealDeal = meal
        navigationController.pushViewController(vc, animated: true)
    }
    
    func collect(order: Order) {
        let vc = CollectOrderViewController.instantiate()
        vc.coordinator = self
        vc.orderToCollect = order
        navigationController.pushViewController(vc, animated: true)
    }
}
