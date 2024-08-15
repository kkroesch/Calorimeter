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
        VStack {
            Text("Gewicht").bold()
            Chart {
                ForEach(weightEntries) { entry in
                    LineMark(
                        x: .value("Datum", entry.timestamp),
                        y: .value("kg", entry.kilograms)
                    )
                }
            }
        }
        .frame(height: 200)
        .padding()
    }
}

#Preview {
    WeightChartView()
}
