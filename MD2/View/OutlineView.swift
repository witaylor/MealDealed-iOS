//
//  OutlineView.swift
//  MD2
//
//  Created by Will Taylor on 06/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class OutlineView: UIView {

    @IBInspectable
    var outline: Bool = false {
        didSet {
            setOutline()
        }
    }

    
    private func setOutline() {
        backgroundColor = .clear
        
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = outline ? 1 : 0
        
    }
    
}
