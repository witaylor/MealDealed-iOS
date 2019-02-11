//
//  Order.swift
//  MD2
//
//  Created by Will Taylor on 01/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import Foundation

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
    
    private var dateOrdered = Date()
    private var collected   = false
    
    private var customer: User
    
    init(forCustomer customer: User) {
        self.customer = customer
    }
    
    init(forCustomer customer: User, withMealDeal mealDeal: MealDeal) {
        self.customer = customer
        self.mealDeal = mealDeal
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
    
}
