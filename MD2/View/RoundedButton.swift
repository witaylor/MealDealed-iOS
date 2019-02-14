//
//  RoundedButton.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    @IBInspectable private var cornerRadius: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupButton()
    }
    
    func setupButton() {
        self.layer.cornerRadius = cornerRadius
    }
}
