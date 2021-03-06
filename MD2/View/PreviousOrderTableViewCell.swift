//
//  PreviousOrderTableViewCell.swift
//  MD2
//
//  Created by Will Taylor on 16/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class PreviousOrderTableViewCell: UITableViewCell {

    // MARK: - @IBOutlets
    
    @IBOutlet var orderDateLabel: UILabel!
    @IBOutlet var reorderButton: RoundedButton!
    @IBOutlet var collectButton: RoundedButton!
    
    @IBOutlet var itemImageViews: [UIImageView]!
    @IBOutlet var itemLabels: [UILabel]!
    
    var order: Order! {
        didSet {
            setupCell()
        }
    }
    var reorderFunction: ((MealDeal) -> ())?
    var collectFunction: ((Order) -> ())?
   
    private func setupCell() {
        let date = order.dateOrdered
        let dateString = date.description
        let formattedDateString = convertDateFormater(dateString)
        
        orderDateLabel.text = "\(formattedDateString)"
        
        itemLabels.forEach { (label) in
            switch label.tag {
            case 0: label.text = order.getItem(inCatagory: .Main)?.name
            case 1: label.text = order.getItem(inCatagory: .Snack)?.name
            case 2: label.text = order.getItem(inCatagory: .Drink)?.name
            default: break
            }
        }
        
        if !order.readyForCollection {
            collectButton.backgroundColor = collectButton.backgroundColor?.withAlphaComponent(0.5)
            collectButton.isEnabled = false
        }
    }
    
    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
    
    // MARK: - @IBActions
    @IBAction func reorderButton_touchUpInside(_ sender: Any) {
        if let reorder = self.reorderFunction {
            reorder(order.getMealDeal())
        }
    }
    
    @IBAction func collectionButton_touchUpInside(_ sender: Any) {
        if let collect = self.collectFunction {
            collect(order)
        }
    }
}
