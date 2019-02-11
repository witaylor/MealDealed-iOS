//
//  OrderManager.swift
//  MD2
//
//  Created by Will Taylor on 01/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import Foundation

class OrderManager {
    
    private var orderList = [Order]()
    
    init() {
        
    }
    
    /// Returns last order placed, nil if none
    /// Will return last order, even if it's already compelted (collected)
    func getLastOrder() -> Order? {
        return orderList.last
    }
    
    func placeOrder(_ order: Order) {
        orderList.append(order)
    }
    
}
