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
    var id: UUID
    var uniUsername: String // e.g. abc123
    
    init(name: String, uniUsername: String) {
        self.name = name
        self.uniUsername = uniUsername
        self.id = UUID()
        
        print("new user:")
        print("name: \(name)")
        print("uni : \(uniUsername)")
        print("uuid: \(id)")
    }
}
