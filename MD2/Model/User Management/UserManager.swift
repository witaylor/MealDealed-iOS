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

//    private func saveState() {} // TODO: Save current signed in user, for between sessions
//    private func loadState() {}
    
    func getCurrentUser() -> User? {
        return currentUser
    }
    
    func registerUser(name: String, uniUsername: String) {
//        let user = User(name: name, uniUsername: uniUsername)
        
        // TODO: - ADD TO USER LIST
    }
    
    private func CREATE_TEST_USER() {
        let user = User(name: "Will Taylor", uniUsername: "wat23")
        currentUser = user
    }
}
