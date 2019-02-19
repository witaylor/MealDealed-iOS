//
//  UserManager.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
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
        var user = User(name: "Will Taylor", uniUsername: "wat23")
        user.id = UUID(uuidString: "8A506A69-B6BD-49E1-A69C-9D80A0D5FDC0")!
        currentUser = user
    }
}
