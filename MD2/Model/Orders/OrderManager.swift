//
//  OrderManager.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import Foundation
import FirebaseFirestore

class OrderManager {
    
    private let db: Firestore
    private var orderList = [Order]()
    private var currentUser: User
    
    init(forUser user: User) {
        self.db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
        self.currentUser = user
    }

    
    func loadOrders(forUser user: User) {
        db.collection("orders").whereField("customerUniId", isEqualTo: currentUser.uniUsername).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting order history: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    let order = Order(fromFirebaseData: data, customer: self.currentUser)
                    self.orderList.append(order)
                }
            }
        }
    }
    
    /// Returns last order placed, nil if none
    /// Will return last order, even if it's already compelted (collected)
    func getLastOrder() -> Order? {
        return orderList.last
    }
    
    func placeOrder(_ order: Order) {
        orderList.append(order) // append to local list
        
        saveToFirebase(order)
    }
    
    private func saveToFirebase(_ order: Order) {
        let orderID = "\(order.customer.uniUsername)\(order.dateOrdered)"
        
        db.collection("orders").document(orderID).setData([
            "customerName": order.customer.name,
            "customerUniId": order.customer.uniUsername,
            "main": order.getMealDeal().main!.name,
            "snack": order.getMealDeal().snack!.name,
            "drink":order.getMealDeal().drink!.name,
            "collected":order.collected
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func orderCount() -> Int {
        return orderList.count
    }
    
    func order(forIndex index: Int) -> Order {
        return orderList[index]
    }    
}
