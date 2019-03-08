//
//  LoginViewController.swift
//  MD2
//
//  Created by Will Taylor on 07/03/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, Storyboarded, UITextFieldDelegate {
    weak var coordinator: MainCoordinator?
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Login"
        
        emailTextField.tag = 0
        emailTextField.delegate = self
        
        passwordTextField.tag = 1
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        if textField.tag == 1 {
            textField.resignFirstResponder()
        }
        return true
    }

    @IBAction func signInButton_touchUpInside(_ sender: Any) {
//        guard let nameText = "__TEST_NAME__" else { return }
        let nameText = "__TEST_NAME__"
        guard let email    = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        let atIndex = email.firstIndex(of: "@")
        let username = email.prefix(upTo: atIndex!)
        let suffix  = email.suffix(from: atIndex!) // get everything after @
        
        print("user: \(username)")
        print("email: \(suffix)")
        
        if suffix != "@bath.ac.uk" {
            showErrorAlert(title: "Incorrect Email!", message: "Please use your bath.ac.uk email address.")
            return
        }
        
        if password.count < 6 {
            showErrorAlert(title: "Short Password", message: "Your password must be at least 6 characters.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else {
                fatalError()
            }
            
            if error != nil {
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .wrongPassword:
                        strongSelf.showErrorAlert(title: "Incorrect Password", message: "Please try again.")
                    default:
                        print("Create User Error: \(error!)")
                    }
                }
            } else {
                print("all good... continue")
            }
            
        
            if error?.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                self?.coordinator?.userManager.registerUser(name: nameText, withEmail: email, password: password)
                self?.coordinator?.start(login: false, animated: true)
            }
            
            if error == nil {
                print("\n\n")
                print("SIGNED IN AS \(user?.user.email)")
                
                self!.removeFromParent()
                self?.coordinator?.start(login: false, animated: true)
            }
        }
    }
}
