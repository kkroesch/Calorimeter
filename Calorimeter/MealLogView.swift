//
//  MealLogView.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 09.08.2024.
//

import SwiftUI
import SwiftData

struct MealLogView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \MealEntry.timestamp, order: .reverse) private var mealEntries: [MealEntry]
    
    var groupedMealEntries: [String: [MealEntry]] {
        Dictionary(grouping: mealEntries) { entry in
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: entry.timestamp)
        }
    }
    
    @State private var showCreateView = false
    @State private var showScannerView = false
    @State private var showFavoritesView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(groupedMealEntries.keys.sorted(), id: \.self) { timestamp in
                    let dailyMeals = groupedMealEntries[timestamp]!
                    let dailyCalories = dailyMeals.reduce(0) { $0 + $1.calories }
                    
                    Section(header: Text(timestamp)) {
                        ForEach(groupedMealEntries[timestamp]!, id: \.id) { mealEntry in
                            HStack {
                                Text(mealEntry.name)
                                Text("\(mealEntry.calories)")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                        HStack {
                            Text("Gesamt").bold()
                            Text("\(dailyCalories)")
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Mahlzeiten")
            .toolbar {
                Button(action: {
                    showCreateView = true
                }) {
                    Label("Eingeben", systemImage: "plus")
                }
                Button(action: {
                    showScannerView = true
                }) {
                    Label("Scannen", systemImage: "barcode.viewfinder")
                }
                Button(action: {
                    showFavoritesView = true
                }) {
                    Label("Favoriten", systemImage: "star")
                }
            }
            .sheet(isPresented: $showCreateView) {
                MealEntryForm()
            }
            .sheet(isPresented: $showScannerView) {
                ScannerView()
            }
            .sheet(isPresented: $showFavoritesView) {
                FavoritesListView()
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(mealEntries[index])
            }
        }
    }
}

#Preview {
    MealLogView()
        .modelContainer(for: MealEntry.self, inMemory: true)
}
