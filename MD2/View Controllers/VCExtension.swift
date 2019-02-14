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
        let alert = createErrorAlert(title: title, message: message)
        present(alert, animated: true, completion: nil)
    }
    
    func createErrorAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Return", style: .cancel)
        alert.addAction(cancelAction)
        
        return alert
    }
    
}
