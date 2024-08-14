//
//  MealChartView.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 12.08.2024.
//

import SwiftUI
import SwiftData
import Charts

struct MealChartView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \MealEntry.timestamp, order: .reverse) private var mealEntries: [MealEntry]
    
    var body: some View {
        Chart {
            ForEach(mealEntries, id: \.id) { mealEntry in
                BarMark(
                    x: .value("Datum", mealEntry.timestamp),
                    y: .value("Kalorien", mealEntry.calories)
                )
            }
        }
        .frame(height: 300)
        .padding()
    }
}

#Preview {
    MealChartView()
}
