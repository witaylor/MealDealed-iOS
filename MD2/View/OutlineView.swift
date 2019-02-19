//
//  OutlineView.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class OutlineView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10
        
        self.setOutline()
    }
    
    private func setOutline() {
        backgroundColor   = .clear
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}
