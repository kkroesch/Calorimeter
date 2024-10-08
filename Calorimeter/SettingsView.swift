//
//  SettingsView.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 12.08.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
    @AppStorage("waterReminderEnabled") private var waterReminderEnabled = false
    @AppStorage("desiredWeight") private var desiredWeight = 75.0
    @AppStorage("dailyCaloriesConsumption") private var dailyCaloriesConsumption = -1
    @AppStorage("dailyWaterGoal") private var dailyWaterGoal:Int = 1
    
    
    @State private var showBasicConsumptionSheet = false
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("App-Einstellungen")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Text("Benachrichtigungen")
                    }
                }
                Section(header: Text("Persönlich")) {
                    Stepper("Wunschgewicht: \(Int(desiredWeight)) kg", value: $desiredWeight)
                    HStack {
                        Text("Grundverbrauch")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        if dailyCaloriesConsumption < 0 {
                            Button(action: {
                                showBasicConsumptionSheet = true
                            }, label: {
                                Text("Berechnen")
                                    .foregroundStyle(Color.blue)
                            })
                        } else {
                            Text("\(dailyCaloriesConsumption) kCal")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            Button(action: {
                                showBasicConsumptionSheet = true
                            }, label: {
                                Image(systemName: "arrow.2.circlepath")
                                    .foregroundStyle(Color.blue)
                            })
                        }
                    }
                }
                Section(header: Text("Wasser trinken")) {
                    Stepper("Tagesziel: \(Int(dailyWaterGoal)) Liter", value: $dailyWaterGoal, in: 1...6)
                    Toggle(isOn: $waterReminderEnabled) {
                        Text("Erinnern")
                    }
                }
            }
            .sheet(isPresented: $showBasicConsumptionSheet, content: {
                ConsumptionCalculatorForm()
            })
            .navigationTitle("Einstellungen")
        }
    }
}

#Preview {
    SettingsView()
}

