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
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Login"
        self.navigationItem.hidesBackButton = true
        
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
        guard let nameText = nameTextField.text     else { return }
        guard let email    = emailTextField.text    else { return }
        guard let password = passwordTextField.text else { return }
        
        let atIndex  = email.firstIndex(of: "@")
        let username = email.prefix(upTo: atIndex!)
        let suffix   = email.suffix(from: atIndex!) // get everything after @
        
        print("user: \(username)")
        print("email: \(suffix)")
        
        if suffix != "@bath.ac.uk" {
            showErrorAlert(title: "Incorrect Email!", message: "Please use your bath.ac.uk email address.")
        }
        else if password.count < 6 {
            showErrorAlert(title: "Short Password", message: "Your password must be at least 6 characters.")
            return
        }
        else {
            coordinator?.userManager.signInUser(name: nameText, email: email, password: password)
        }
    }
}
