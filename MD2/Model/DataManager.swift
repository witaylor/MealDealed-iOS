//
//  DataManager.swift
//  MealDealed
//
//  Created by Will Taylor on 12/02/2019.
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
    
    private var loadItemsCalled = false // flag to prevent infinite calling of store.load()
    
    public static let shared = DataManager()
    private init() {
        self.loadItems()
    }
    
    func loadItems() {
        store.load() { (res) in
            if let items = res {
                self.allItems = items
                
                for item in items {
                    self.sortedItems[item.catagory.rawValue]?.append(item)
                }
            }
        }
    }
    
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
    
    func getItems(catagory: FoodCatagory) -> [FoodItem] {
        #warning("Unsafe unwrap - bad!")
        print("\n~~~~~ returning -- \(sortedItems[catagory.rawValue]!)\n")
        return sortedItems[catagory.rawValue]!
    }
    
}
