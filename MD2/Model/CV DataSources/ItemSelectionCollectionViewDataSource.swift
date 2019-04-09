//
//  ItemSelectionCollectionViewDataSource.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class ItemSelectionCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var items: [FoodItem]!
    
    init(forCatagory catagory: FoodCatagory) {
        super.init()
        
        self.items = DataManager.shared.getItems(catagory: catagory)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .clear
        cell.item = items[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: - Item Selection
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? ItemCollectionViewCell else { return }
        
        selectedCell.selected(true)
        DataManager.shared.addToMealDeal(selectedCell.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let deselectedCell = collectionView.cellForItem(at: indexPath) as? ItemCollectionViewCell else { return }
        
        deselectedCell.selected(false)
        DataManager.shared.removeFromMealDeal(deselectedCell.item.catagory)
    }
}


extension ItemSelectionCollectionViewDataSource: UICollectionViewDelegate { }
extension ItemSelectionCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width  = (collectionView.frame.width / 3)-4
        return CGSize(width: width, height: 180)
    }
}
