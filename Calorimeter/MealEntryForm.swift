//
//  MealEntryForm.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 09.08.2024.
//

import SwiftUI

struct MealEntryForm: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var favoritButtonColor: Color = .blue
    
    @State private var timestamp: Date = Date()
    @State private var name: String = ""
    @State private var portions: Double = 1.0
    @State private var kilocalories: Int = 100
    @State private var isFavorite = false
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Datum", selection: $timestamp, displayedComponents: .date )
                TextField("Name", text: $name)
                HStack {
                    Text("Nährwert")
                    TextField("", value: $kilocalories, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("kCal")
                }
                Stepper(value: $portions, in: 1...10, step: 0.5) {
                    HStack {
                        Text("Portionen")
                        Spacer()
                        Text("\(portions, specifier: "%.1f")")
                    }
                }
                Spacer()
            }
            .navigationTitle("Neuer Eintrag")
            .toolbar {
                Button {
                    isFavorite.toggle()
                } label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .yellow : .gray)
                        .padding()
                }
                Button("Speichern") {
                    let meal = MealEntry(timestamp: timestamp, name: name, portions: portions, calories: kilocalories)
                    meal.isFavorite = isFavorite
                    modelContext.insert(meal)
                    dismiss()
                }
            }
        }
        
    }
}

#Preview {
    MealEntryForm()
}
