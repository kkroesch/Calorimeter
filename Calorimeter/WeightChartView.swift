//
//  WeightChartView.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 12.08.2024.
//

import SwiftUI
import SwiftData
import Charts

struct WeightChartView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \WeightEntry.timestamp) private var weightEntries: [WeightEntry]
    
    var body: some View {
        Chart {
            ForEach(weightEntries, id: \.id) { weightEntry in
                LineMark(
                    x: .value("Datum", weightEntry.timestamp),
                    y: .value("kg", weightEntry.kilograms)
                )
            }
        }
        .frame(height: 300)
        .padding()
    }
}

#Preview {
    WeightChartView()
}
