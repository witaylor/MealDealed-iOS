//
//  ItemPageCollectionViewDataSource.swift
//  MD2
//
//  Created by Will Taylor on 03/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import UIKit

class ItemPageCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    // MARK: - CollectionView DataSources
    
    var mainSelectionDataSource: ItemSelectionCollectionViewDataSource = {
        let itemSelectionDataSource = ItemSelectionCollectionViewDataSource(forCatagory: .Main)
        return itemSelectionDataSource
    }()
    
    var snackSelectionDataSource: ItemSelectionCollectionViewDataSource = {
        let itemSelectionDataSource = ItemSelectionCollectionViewDataSource(forCatagory: .Snack)
        return itemSelectionDataSource
    }()
    
    var drinkSelectionDataSource: ItemSelectionCollectionViewDataSource = {
        let itemSelectionDataSource = ItemSelectionCollectionViewDataSource(forCatagory: .Drink)
        return itemSelectionDataSource
    }()
    
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3 // mains, snack, drink
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemPageCell", for: indexPath)
        cell.backgroundColor = .clear
        
        let itemCollectionView = setupCollectionView(forCell: cell, atIndex: indexPath)
        cell.addSubview(itemCollectionView)
        
        return cell
    }
    
    private func setupCollectionView(forCell cell: UICollectionViewCell, atIndex index: IndexPath) -> UICollectionView {
        var dataSource = mainSelectionDataSource
        if index.item == 1 { dataSource = snackSelectionDataSource }
        if index.item == 2 { dataSource = drinkSelectionDataSource }
        
        let collectionView = setupItemCollectionView(forCell: cell, dataSource: dataSource)
        return collectionView
    }
    
    private func setupItemCollectionView(forCell cell: UIView, dataSource: ItemSelectionCollectionViewDataSource) -> UICollectionView {
        let layout = setupCollectionViewLayout()
        
        let itemCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height), collectionViewLayout: layout   )
        itemCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")
        
        itemCollectionView.dataSource = dataSource
        itemCollectionView.delegate   = dataSource
        
        itemCollectionView.backgroundColor = .clear
        itemCollectionView.allowsMultipleSelection = false
        
        return itemCollectionView
    }
    
    private func setupCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
}

extension ItemPageCollectionViewDataSource: UICollectionViewDelegate { }
extension ItemPageCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
