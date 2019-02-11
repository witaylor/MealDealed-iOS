//
//  ItemSelectionViewController.swift
//  MD2
//
//  Created by Will Taylor on 02/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class ItemSelectionViewController: UIViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet var itemCatagoryButtons: [RoundedButton]!
    @IBOutlet var itemCollectionView: UICollectionView!
    
    lazy var dataController: ItemPageCollectionViewDataSource = {
        let dataController = ItemPageCollectionViewDataSource()
        return dataController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemCollectionView.dataSource = self.dataController
        itemCollectionView.delegate   = self.dataController
        
        self.navigationItem.largeTitleDisplayMode = .never
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
        itemCollectionView.scrollToItem(at: IndexPath(item: page, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func checkoutButton_touchUpInside(_ sender: Any) {
        
        let mealDeal = DataManager.shared.getCurrentOrder()
        if mealDeal.isFull() { // has main, snack & drink
            performSegue(withIdentifier: "SelectToCheckoutSegue", sender: self)
        } else {
            showErrorAlert(title: "Something's Missing!", message: "You must select a main, snack and a drink before going to checkout.")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectToCheckoutSegue" {
            guard let destVC = segue.destination as? CheckoutViewController else { return }
            destVC.mealDeal = DataManager.shared.getCurrentOrder()
        }
    }
    
    
}
