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
    var connection: Connection
    var userManager: UserManager
    var orderManager: OrderManager?
    
    private var initialScreen = true
    
    init(navController: UINavigationController) {
        self.connection = Connection()
        
        self.userManager = UserManager()
        DataManager.shared.loadItems() // begin loading items ASAP
        
        self.navigationController = navController
        setupNavBar()
        
        self.userManager.startFunction = self.start
    }
    
    private func setupNavBar() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.barTintColor = UIColor(red: 246/255, green: 168/255, blue: 89/255, alpha: 1)
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func start() {
        // TODO check for internet connection;
        // if none && signed in :: go to previous orders.
        // if none && not signed in :: go to login & display error "need internet connection"
        
        if self.connection.connected() { // if connected
            // Go to homepage
            let vc = HomeViewController.instantiate()
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: false)
        
            // check if user signed in
            let currentUser = userManager.getCurrentUser()
            
            // if no user, show login
            if currentUser == nil {
                login()
            } else {
                // User is signed in - get all orders
                self.orderManager = OrderManager(forUser: userManager.getCurrentUser()!)
                self.orderManager?.loadOrders(forUser: userManager.getCurrentUser()!)
            }
            
            initialScreen = false
        } else {
            viewPreviousOrders()
        }
    }
    
    private func login() {
        let vc = LoginViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
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
        self.checkout(withMeal: meal, allowReturn: true)
    }
    
    func checkout(withMeal meal: MealDeal, allowReturn: Bool) {
        let vc = CheckoutViewController.instantiate()
        vc.coordinator = self
        vc.mealDeal = meal
        vc.allowReturn = allowReturn
        navigationController.pushViewController(vc, animated: true)
    }
    
    func collect(order: Order) {
        let vc = CollectOrderViewController.instantiate()
        vc.coordinator = self
        vc.orderToCollect = order
        navigationController.pushViewController(vc, animated: true)
    }
}
