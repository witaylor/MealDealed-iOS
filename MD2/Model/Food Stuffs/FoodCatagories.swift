//
//  FoodCatagories.swift
//  MD2
//
//  Created by Will Taylor on 12/02/2019.
//  Copyright © 2019 Will Taylor. All rights reserved.
//

import Foundation

/// Used alongside FoodSubCatagory;
/// Main catagory -> Sorts into CollectionView
public enum FoodCatagory: String {
    case Main = "M", Snack = "S", Drink = "D"
}

/// Used alongside FoodCatagory;
/// Sub catagory  -> Sorts into Section
public enum FoodSubCatagory {
    // MAINS
    case Sandwich, Wrap, Pasta, Salad
    // SNACKS
    case Crisps, Chocolate
    // DRINKS
    case Fizzy, Still, FruitDrink
    case Other
}
