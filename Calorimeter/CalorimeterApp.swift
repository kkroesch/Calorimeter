//
//  CalorimeterApp.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 09.08.2024.
//

import SwiftUI
import SwiftData

@main
struct CalorimeterApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            WeightEntry.self,
            MealEntry.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
