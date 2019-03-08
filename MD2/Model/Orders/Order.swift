//
//  Order.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

struct MealDeal {
    var main:  FoodItem?
    var snack: FoodItem?
    var drink: FoodItem?
    
    func isFull() -> Bool {
        return ((main != nil) && (snack != nil) && (drink != nil))
    }
}

struct Order {
    private var mealDeal: MealDeal = MealDeal()
    
    private(set) var dateOrdered = Date() 
    var collected   = false
    
    var customer: User
    private(set) var qrCode: UIImage? // from string: customerUuid + dateOrdered
    
    init(forCustomer customer: User) {
        self.customer = customer
        self.qrCode = QRCode.generate(from: "\(customer.uniUsername)\(dateOrdered)")
    }
    
    init(forCustomer customer: User, withMealDeal mealDeal: MealDeal) {
        self.customer = customer
        self.mealDeal = mealDeal
        
        self.qrCode = QRCode.generate(from: "\(customer.uniUsername)\(dateOrdered)")
    }
    
    init(fromFirebaseData data: [String: Any], customer: User) {
        let mainName  = data["main"] as! String
        let snackName  = data["snack"] as! String
        let drinkName  = data["drink"] as! String
        let collected = data["collected"] as! Bool
        
        self.customer = customer
        
        self.addToOrder(item: FoodItem(name: mainName, catagory: .Main, subCatagory: nil))
        self.addToOrder(item: FoodItem(name: snackName, catagory: .Snack, subCatagory: nil))
        self.addToOrder(item: FoodItem(name: drinkName, catagory: .Drink, subCatagory: nil))
        
        self.collected = collected
    }
    
    mutating func addToOrder(item: FoodItem) {
        if item.catagory == .Main  { self.mealDeal.main  = item }
        if item.catagory == .Snack { self.mealDeal.snack = item }
        if item.catagory == .Drink { self.mealDeal.drink = item }
    }
    
    mutating func removeFromOrder(_ catagory: FoodCatagory) {
        if catagory == .Main  { self.mealDeal.snack = nil }
        if catagory == .Snack { self.mealDeal.snack = nil }
        if catagory == .Drink { self.mealDeal.snack = nil }
    }
    
    func getItem(inCatagory catagory: FoodCatagory) -> FoodItem? {
        switch catagory {
        case .Main:
            return mealDeal.main
        case .Snack:
            return mealDeal.snack
        case .Drink:
            return mealDeal.drink
        }
    }
    
    func isFull() -> Bool {
        let hasMain  = (self.mealDeal.main  != nil)
        let hasSnack = (self.mealDeal.snack != nil)
        let hasDrink = (self.mealDeal.drink != nil)
        
        return (hasMain && hasSnack && hasDrink) // true if all are != nil
    }
    
    func getMealDeal() -> MealDeal {
        return self.mealDeal
    }
    
}
