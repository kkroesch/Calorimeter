//
//  ConsuptionCalculatorForm.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 12.08.2024.
//

import SwiftUI

struct ConsumptionCalculatorForm: View {
    
    @AppStorage("dailyCaloriesConsumption") private var dailyCaloriesConsumption = -1
    @Environment(\.dismiss) var dismiss

    @AppStorage("gender") private var selectedGender: String = "M"
    @AppStorage("currentAge") private var age:Double = 30
    @AppStorage("currentWeight") private var weight:Double = 75
    @AppStorage("height") private var height: Double = 175
    @AppStorage("currentActiveLevel") private var selectedWork: Double = 1.2
    

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Geschlecht auswählen")) {
                    Picker("Geschlecht", selection: $selectedGender) {
                        Text("Männlich").tag("M")
                        Text("Weiblich").tag("F")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                HStack {
                    Text("Alter")
                    TextField("Jahre", value: $age, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                    Text("Jahre")
                }
                HStack {
                    Text("Körpergröße")
                    TextField("cm", value: $height, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                    Text("cm")
                }
                HStack {
                    Text("Gewicht")
                    TextField("kg", value: $weight, formatter: NumberFormatter())
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                    Text("kg")
                }
                Section(header: Text("Aktiviät")) {
                    Picker("Alltag", selection: $selectedWork) {
                        Text("wenig (nur sitzen)").tag(1.2)
                        Text("etwas (meist sitzen)").tag(1.4)
                        Text("aktiv (viel laufen)").tag(1.6)
                        Text("sehr aktiv (hart arbeiten)").tag(1.8)
                    }
                }
                Section(header: Text("Aktiviät")) {
                    HStack {
                        Text("Grundumsatz")
                        Text("\(Int(calculateBasicConsumption())) kCal")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    HStack {
                        Text("Gesamt")
                            .bold()
                        Text("\(Int(calculateTotalConsumption())) kCal")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .bold()
                    }
                }
            }
            .navigationTitle("Verbrauch")
            .toolbar {
                Button("Speichern") {
                    dailyCaloriesConsumption = Int(calculateTotalConsumption())
                    dismiss()
                }
            }
        }
    }
    
    private func calculateBasicConsumption() -> Double {
        if selectedGender == "M" {
            let consumption: Double = 66.47 + (13.7 * weight) + (5.0 * height) - (6.8 * age)
            return consumption
        } else {
            let consumption: Double = 655.1 + (9.6 * weight) + (1.8 * height) - (4.7 * age)
            return consumption
        }
    }
    
    private func calculateTotalConsumption() -> Double {
        return selectedWork * calculateBasicConsumption()
    }
}

#Preview {
    ConsumptionCalculatorForm()
}
