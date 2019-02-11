//
//  FoodItem.swift
//  MD2
//
//  Created by Will Taylor on 01/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import Foundation

struct FoodItem {
    var name: String
    var catagory: FoodCatagory
    var subCatagory: FoodSubCatagory
    
    init(name: String, catagory: FoodCatagory, subCatagory: FoodSubCatagory?) {
        self.name = name
        self.catagory = catagory
        self.subCatagory = subCatagory ?? .Other
    }
    
    func toDataItem() -> DataItem {
        return DataItem(name: self.name, catagory: self.catagory)
    }
}

struct DataItem: Codable {
    var name: String
    var catagory: String
//    var subCatagory: String // unused for now
    
    init(name: String, catagory: FoodCatagory) {
        self.name = name
        self.catagory = catagory.rawValue // M || S || D
//        self.subCatagory = ""
    }
    
    func toFoodItem() -> FoodItem {
        var mainCatagory: FoodCatagory = .Main
        
        if catagory == FoodCatagory.Main.rawValue  { mainCatagory = .Main }
        if catagory == FoodCatagory.Snack.rawValue { mainCatagory = .Snack }
        if catagory == FoodCatagory.Drink.rawValue { mainCatagory = .Drink }
        
        return FoodItem(name: self.name, catagory: mainCatagory, subCatagory: .Other)
    }
}
