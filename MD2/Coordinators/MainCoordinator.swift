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
        navigationController.pushViewController(vc, animated: false)
    }
    
    // MARK: - Navigation Functions
    
    func startNewOrder() {
        let vc = NewOrderViewController.instantiate()
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
        navigationController.pushViewController(vc, animated: true)
    }
}
