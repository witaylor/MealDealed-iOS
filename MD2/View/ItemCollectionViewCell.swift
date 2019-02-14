//
//  ItemCollectionViewCell.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    // MARK: - Cell Subviews
    private var itemImageView = UIImageView()
    private var itemLabel     = UILabel()
    
    var item: FoodItem! {
        didSet { setCellContent() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }
    
    
    private func setupCell() {
        self.heightAnchor.constraint(equalToConstant: 175)
        
        self.addSubview(itemImageView)
        setupImageView()
        
        self.addSubview(itemLabel)
        setupLabel()
    }
    
    private func setCellContent() {
        itemLabel.text = item.name
        
        if item.catagory == .Main  { itemImageView.image = UIImage(named: "Main")  }
        if item.catagory == .Snack { itemImageView.image = UIImage(named: "Snack") }
        if item.catagory == .Drink { itemImageView.image = UIImage(named: "Drink") }
    }
    
    // MARK: - Item ImageView
    
    private func setupImageView() {
        itemImageView.backgroundColor = .lightGray
        setImageViewConstraints()
    }
    
    private func setImageViewConstraints() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false // enables Auto-Layout
        
        itemImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true      // center horizontally
        itemImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true // 8pt from top of cell
        
        // 1:1 Aspect Ratio
        itemImageView.widthAnchor.constraint(equalToConstant: (self.frame.width - 4)).isActive = true
        itemImageView.heightAnchor.constraint(equalTo: itemImageView.widthAnchor).isActive = true
    }
    
    // MARK: - Item Label
    
    private func setupLabel() {
        itemLabel.lineBreakMode = .byWordWrapping
        itemLabel.textAlignment = .center
        
        // idk if this is needed, need to set 0 in IB for wrapping so figured it's needed here
        itemLabel.numberOfLines = 0
        
        setupLabelConstraints()
    }
    
    private func setupLabelConstraints() {
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        
        itemLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        itemLabel.leftAnchor.constraint(equalTo: itemImageView.leftAnchor, constant: 0).isActive = true
        itemLabel.rightAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 0).isActive = true
        
        itemLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 4).isActive = true
        itemLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
    }
}
