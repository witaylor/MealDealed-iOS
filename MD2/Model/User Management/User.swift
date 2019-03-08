//
//  User.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import Foundation

struct User {
    
    var name: String
    var uniUsername: String // e.g. abc123
    
    init(name: String, uniUsername: String) {
        self.name = name
        self.uniUsername = uniUsername
    }
    
    init(name: String, withEmail email: String) {
        self.name = name
        
        let username = email.prefix(upTo: email.firstIndex(of: "@")!)
        print("Creating user: \(name) :: \(username)")
        self.uniUsername = String(username)
    }
}
