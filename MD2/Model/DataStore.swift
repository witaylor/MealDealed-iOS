//
//  DataStore.swift
//  MealDealed
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import Foundation
import FirebaseFirestore

class DataStore {
    
    let dataURL = Bundle.main.path(forResource: "Items", ofType: "json")
    let db = Firestore.firestore()
    
    // MARK: - Save Data
    
    func save(_ mealObjects: [FoodItem]) {
        mealObjects.forEach { (item) in
            let dataItem = item.toDataItem()
            
            var ref: DocumentReference? = nil
            ref = db.collection("stock").addDocument(data: [
                "name": dataItem.name,
                "catagory": dataItem.catagory
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
    }
    
    // MARK: - Loading Data
    
    func load() -> [FoodItem] {
        if let path = dataURL {
            let dataObjects = decodeData(URL(fileURLWithPath: path))
            var mealObjects = [FoodItem]()
            
            dataObjects.forEach { (obj) in
                mealObjects.append(obj.toFoodItem())
            }
            
            return mealObjects
        } else {
            print("ERROR: Could not load from JSON (1: DS L52)")
        }
        
        return [FoodItem]()
    }
    
    private func decodeData(_ path: URL) -> [DataItem] {
        if let data = try? Data(contentsOf: path) {
            let decoder = JSONDecoder()
            do {
                return try decoder.decode([DataItem].self, from: data)
            } catch {
                print("ERROR: Could not load from JSON (2: DS L64)")
            }
        }
        return [DataItem]()
    }
}
