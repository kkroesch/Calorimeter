//
//  WeightEntryForm.swift
//  Journal
//
//  Created by Karsten Kroesch on 09.08.2024.
//

import SwiftUI

struct WeightEntryForm: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var timestamp: Date = Date()
    @State private var kilograms: Double = 76.0
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Datum", selection: $timestamp, displayedComponents: .date )
                TextField("Gewicht (kg)", value: $kilograms, formatter: formatter)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Neuer Eintrag")
            .toolbar {
                Button("Speichern") {
                    let weight = WeightEntry(timestamp: timestamp, kilograms: kilograms)
                    modelContext.insert(weight)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    WeightEntryForm()
}
