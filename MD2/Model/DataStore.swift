//
//  DataStore.swift
//  MealDealed
//
//  Created by Will Taylor on 26/01/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import Foundation

class DataStore {
    
    let dataURL = Bundle.main.path(forResource: "Items", ofType: "json")
    
    // MARK: - Save Data
    
    func save(_ mealObjects: [FoodItem]) {
        if let path = dataURL {
            var dataObjects = [DataItem]()
            mealObjects.forEach { (obj) in
                dataObjects.append(obj.toDataItem())
            }
            
            encodeData(objects: dataObjects, forURL: URL(fileReferenceLiteralResourceName: path))
        }
    }
    
    private func encodeData(objects: [DataItem], forURL path: URL) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(objects)
            try data.write(to: path)
        } catch {
            print("ERROR: could not write JSON (1: DS L34)")
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
