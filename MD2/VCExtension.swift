//
//  VCExtension.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(title: String, message: String) {
        let alert = createErrorAlert(title: title, message: message, returnMessage: "Return")
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(title: String, message: String, returnMessage: String) {
        let alert = createErrorAlert(title: title, message: message, returnMessage: returnMessage)
        present(alert, animated: true, completion: nil)
    }
    
    func createErrorAlert(title: String, message: String, returnMessage: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: returnMessage, style: .cancel)
        alert.addAction(cancelAction)
        
        return alert
    }
}

