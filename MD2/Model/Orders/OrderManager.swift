//
//  OrderManager.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import Foundation

class OrderManager {
    
    private var orderList = [Order]()
    
    init() {}

    
    func loadOrders(forUser user: User) {
        // TODO: Load orders from database for specified user
        
        LOAD_TEST_ORDERS(user) // for now
    }
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////
    
    func LOAD_TEST_ORDERS(_ user: User) {
        // todo: use user.uuid to name a file/directory wiht a list of orders
        var firstOrder = Order(forCustomer: user)
        firstOrder.addToOrder(item: FoodItem(name: "Ham Wrap", catagory: .Main, subCatagory: .Wrap))
        firstOrder.addToOrder(item: FoodItem(name: "Crisps", catagory: .Snack, subCatagory: .Crisps))
        firstOrder.addToOrder(item: FoodItem(name: "Water", catagory: .Drink, subCatagory: .Other))
        
        var secondOrder = Order(forCustomer: user)
        secondOrder.addToOrder(item: FoodItem(name: "Chicken Wrap", catagory: .Main, subCatagory: .Wrap))
        secondOrder.addToOrder(item: FoodItem(name: "Chocolate", catagory: .Snack, subCatagory: .Crisps))
        secondOrder.addToOrder(item: FoodItem(name: "Cola", catagory: .Drink, subCatagory: .Other))
        
        self.orderList = [firstOrder, secondOrder]
    }
    
    /// Returns last order placed, nil if none
    /// Will return last order, even if it's already compelted (collected)
    func getLastOrder() -> Order? {
        return orderList.last
    }
    
    func placeOrder(_ order: Order) {
        orderList.append(order)
    }
    
    func orderCount() -> Int {
        return orderList.count
    }
    
    func order(forIndex index: Int) -> Order {
        return orderList[index]
    }    
}
