//
//  WeightLogView.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 09.08.2024.
//

import SwiftUI
import SwiftData

struct WeightLogView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var weightEntries: [WeightEntry]
    
    @State private var showCreateView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(weightEntries) { entry in
                    HStack {
                        Text("\(entry.timestamp, format: Date.FormatStyle(date: .numeric))")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(String(format: "%.1f", entry.kilograms)) kg")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Gewichtsverlauf")
            .toolbar {
                EditButton()
                Button(action: {
                    showCreateView = true
                }) {
                    Label("Add Item", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showCreateView) {
                WeightEntryForm()
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(weightEntries[index])
            }
        }
    }
}

#Preview {
    WeightLogView()
        .modelContainer(for: WeightEntry.self, inMemory: true)
}
