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
    @Query private var mealEntries: [MealEntry]
    
    @State private var showCreateView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(mealEntries) { entry in
                    HStack {
                        Text("\(entry.timestamp, format: Date.FormatStyle(date: .numeric))")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(entry.calories) kCal")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Mahlzeiten")
            .toolbar {
                EditButton()
                Button(action: {
                    showCreateView = true
                }) {
                    Label("Add Item", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showCreateView) {
                MealEntryForm()
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
