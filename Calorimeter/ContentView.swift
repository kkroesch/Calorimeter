//
//  ContentView.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 09.08.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Dashboard")
                }
            
            MealLogView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Mahlzeiten")
                }
            WeightLogView()
                .tabItem {
                    Image(systemName: "gauge")
                    Text("Gewicht")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Einstellungen")
                }
        }
    }
}

#Preview {
    ContentView()
}
