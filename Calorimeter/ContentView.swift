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
        NavigationStack {
            List() {
                NavigationLink(destination: MealLogView()) {
                    HStack {
                        Image(systemName: "book")
                            .foregroundColor(.blue)
                        Text("Mahlzeiten")
                    }
                }
                NavigationLink(destination: WeightLogView()) {
                    HStack {
                        Image(systemName: "gauge")
                            .foregroundColor(.blue)
                        Text("Gewicht")
                    }
                }
            }
            .navigationTitle("Calorimeter")
        }
    }
}

#Preview {
    ContentView()
}
