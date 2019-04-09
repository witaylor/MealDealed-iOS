//
//  NewOrderViewController.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class NewOrderViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    private let itemButtonColour = UIColor(red: 246/255, green: 168/255, blue: 89/255, alpha: 1)
    
    // MARK: - @IBOutlets
    @IBOutlet var itemCatagoryButtons: [RoundedButton]!
    @IBOutlet var itemCollectionView: UICollectionView!
    
    private var dataController = ItemPageCollectionViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        itemCollectionView.dataSource = self.dataController
        itemCollectionView.delegate   = self.dataController
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        resetItemButtonColour()
        itemCatagoryButtons.first?.backgroundColor = itemButtonColour
    }
    
    private func resetItemButtonColour() {
        // change colour to orange of nav bar
        itemCatagoryButtons.forEach { (btn) in
            btn.backgroundColor = itemButtonColour.withAlphaComponent(0.75)
        }
    }
    
    // MARK: - @IBActions
    
    @IBAction func mainsButton_touchUpInside(_ sender: Any) {
        scrollTo(page: 0)
    }
    
    @IBAction func snacksButton_touchUpInside(_ sender: Any) {
        scrollTo(page: 1)
    }
    
    @IBAction func drinksButton_touchUpInside(_ sender: Any) {
        scrollTo(page: 2)
    }
    
    func scrollTo(page: Int) {
        resetItemButtonColour()
        itemCatagoryButtons[page].backgroundColor = itemButtonColour
        itemCollectionView.scrollToItem(at: IndexPath(item: page, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func checkoutButton_touchUpInside(_ sender: Any) {
        let mealDeal = DataManager.shared.getCurrentOrder()
        
        if mealDeal.isFull() { // has main, snack & drink
            self.coordinator?.checkout(withMeal: mealDeal, allowReturn: false)
        } else {
            let errorMessage = "You must select a main, snack and a drink before going to checkout."
            showErrorAlert(title: "Something's Missing!", message: errorMessage)
        }
    }
    
    
}
