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
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Datum", selection: $timestamp, displayedComponents: .date )
                HStack {
                    Text("Gewogen")
                    TextField("Gewicht (kg)", value: $kilograms, formatter: formatter)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                    Text("kg")
                }
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
