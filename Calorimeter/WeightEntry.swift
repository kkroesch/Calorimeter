//
//  WeightEntry.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 09.08.2024.
//


import Foundation
import SwiftData

@Model
final class WeightEntry {
    var timestamp: Date
    var kilograms: Double
    
    init(timestamp: Date, kilograms: Double) {
        self.timestamp = timestamp
        self.kilograms = kilograms
    }
}
