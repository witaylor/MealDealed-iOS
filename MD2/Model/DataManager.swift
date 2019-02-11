//
//  DataManager.swift
//  MealDealed
//
//  Created by Will Taylor on 26/01/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import Foundation

class DataManager {
    
    private let store = DataStore()
    
    private var allItems: [FoodItem]!
    private var sortedItems: [String: [FoodItem]] = [ "M": [FoodItem](),
                                                      "S": [FoodItem](),
                                                      "D": [FoodItem]()]
    private var currentOrder = MealDeal()
    
    public static let shared = DataManager()
    private init() { loadItems() }
    
    func addToMealDeal(_ item: FoodItem) {
        if item.catagory == .Main {
            currentOrder.main = item
        }
        if item.catagory == .Snack {
            currentOrder.snack = item
        }
        if item.catagory == .Drink {
            currentOrder.drink = item
        }
    }
    
    func removeFromMealDeal(_ catagory: FoodCatagory) {
        switch catagory {
        case .Main:
            currentOrder.main  = nil
        case .Snack:
            currentOrder.snack = nil
        case .Drink:
            currentOrder.drink = nil
        }
    }
    
    func getCurrentOrder() -> MealDeal {
        return self.currentOrder
    }
    
    func loadItems() {
        self.allItems = store.load()
        
        allItems.forEach { (item) in
            // append to sortedItems["M" || "S" || "D"]
            sortedItems[item.catagory.rawValue]?.append(item)
        }
    }
    
    func getItems(catagory: FoodCatagory) -> [FoodItem] {
        return sortedItems[catagory.rawValue] ?? [FoodItem]()
    }
    
}
