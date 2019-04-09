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
        
    var startFunction: (() -> ())?
    
    init() {
//        signOut() // ensure user signed out for testing purposes.
        
        loadCurrentUser()
    }
    
    private func startApp() {
        if let start = startFunction { start() }
    }
    
    func getCurrentUser() -> User? {
        return currentUser
    }
    
    func registerUser(name: String, withEmail email: String, password: String) {
        firebaseAuth.createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                print("\n\n >> \(String(describing: authResult?.user.email!)) created\n\n")
            }
            
            // Add display name - apparently there is no way to do this on creation
            let changeRequest = self.firebaseAuth.currentUser!.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges { (error) in
                if let error = error {
                    print("Error changing user display name.")
                    print(error)
                } else {
                    self.currentUser = User(name: (self.firebaseAuth.currentUser?.displayName)!, withEmail: (self.firebaseAuth.currentUser?.email)!)
                    self.startApp()
                }
            }
        }
    }
    
    func signInUser(name: String, email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else { fatalError() }
            
            if error != nil {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .wrongPassword:
                        print("DEVELOPER: Incorrect password.")
                    case .userNotFound:
                        strongSelf.registerUser(name: name, withEmail: email, password: password)
                    default:
                        print("DEVELOPER: Create User Error: \(error!)")
                    }
                }
            }
        
            if error == nil {
                print("\n\n")
                print("SIGNED IN AS \(String(describing: user?.user.email))")
                
                strongSelf.currentUser = User(name: (strongSelf.firebaseAuth.currentUser?.displayName)!, withEmail: (strongSelf.firebaseAuth.currentUser?.email)!)
                strongSelf.startApp()
            }
        }
    }
    
    private func loadCurrentUser() {
        if let user = firebaseAuth.currentUser {
            if firebaseAuth.currentUser == nil { self.currentUser = nil }
            
            let email = user.email!
            let name = user.displayName!
            
            self.currentUser = User(name: name, withEmail: email)
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
