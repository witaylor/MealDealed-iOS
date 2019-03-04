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
    
    var saveCount = 0
    var loadCount = 0
    
    let dataURL = Bundle.main.path(forResource: "Items", ofType: "json")
    let db: Firestore
    
    init() {
        self.db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
    // MARK: - Save Data
    
    func save(_ mealObjects: [FoodItem]) {
        saveCount += 1
        print("Saving to Firebase :: \(saveCount)")
        
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
    
    func load(completion: @escaping(_ res:[FoodItem]?) -> Void) {
        print("\n\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print("> loading from firebase")
        

        self.db.collection("stock").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("\n>>Error getting documents: \(err)")
                completion(nil)
            } else {
                print("> Load successful")
                var items = [FoodItem]()
                for document in querySnapshot!.documents {
                    print("\n> Attempting: \(document)")
                    let data = document.data()
                    let dataName = data["name"] as! String
                    let dataCat  = data["catagory"] as! String
                    
                    let item = DataItem(name: dataName, catagory: dataCat).toFoodItem()
                    
                    print("> Created: \(item)")
                    
                    items.append(item)
                    print("> Item Appended\n")
                }
                completion(items)
            }
        }
    }
}
