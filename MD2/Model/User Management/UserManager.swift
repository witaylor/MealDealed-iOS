//
//  UserManager.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserManager {
    
    private let firebaseAuth = Auth.auth()
    private var currentUser: User? // nil if none signed in
    
    init() {
        signOut()
        loadCurrentUser()
        
    }
    
    func getCurrentUser() -> User? {
        return currentUser
    }
    
    func registerUser(name: String, withEmail email: String, password: String) {
        firebaseAuth.createUser(withEmail: email, password: password) { authResult, error in
            
            if error == nil {
                print(authResult?.user.uid as Any)
                
                self.currentUser = User(name: (authResult?.user.displayName)!, withEmail: (authResult?.user.email)!)
            }
        }
        
        // Add display name - apparently there is no way to do this on creation
        if let user = firebaseAuth.currentUser {
            let changeRequest = user.createProfileChangeRequest()
            
            changeRequest.displayName = name
            changeRequest.commitChanges { error in
                if let error = error {
                    print("Could not set the display name of the user \(email)")
                } else {
                    print(error)
                }
            }
        }
    }
    
    private func loadCurrentUser() {
        if let user = firebaseAuth.currentUser {
            if firebaseAuth.currentUser == nil { self.currentUser = nil }
            
            self.currentUser = User(name: user.displayName!, withEmail: user.email!)
        }
    }
    
    func signOut() {
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
