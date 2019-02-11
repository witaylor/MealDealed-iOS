//
//  UserManager.swift
//  MD2
//
//  Created by Will Taylor on 01/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import Foundation

class UserManager {
    
    private var currentUser: User? // nil if none signed in
    
    init() { CREATE_TEST_USER() }
    
    func getCurrentUser() -> User? {
        return currentUser
    }
    
    func registerUser(name: String, uniUsername: String) {}
    
    private func CREATE_TEST_USER() {
        let user = User(name: "Will Taylor", uniUsername: "wat23")
        currentUser = user
    }
}
