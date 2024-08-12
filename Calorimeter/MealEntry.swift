//
//  MealEntry.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 09.08.2024.
//


import Foundation
import SwiftData

@Model
final class MealEntry {
    var timestamp: Date
    var name: String
    var portions: Double
    var calories: Int
    var isFavorite: Bool
    
    init(timestamp: Date, name: String, portions: Double, calories: Int) {
        self.timestamp = timestamp
        self.name = name
        self.portions = portions
        self.calories = calories
        self.isFavorite = false
    }
}
