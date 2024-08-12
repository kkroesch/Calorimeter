//
//  FavoritesListView.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 12.08.2024.
//

import SwiftUI
import SwiftData

struct FavoritesListView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<MealEntry> { fav in fav.isFavorite == true }) private var favorites: [MealEntry]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                ForEach(favorites) { entry in
                    HStack {
                        Button(action: {
                            let meal = MealEntry(timestamp: Date(), name: entry.name, portions: entry.portions, calories: entry.calories)
                            modelContext.insert(meal)
                            dismiss()
                        }, label: {
                            Text("\(entry.name)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color.blue)
                        })
                        Text("\(entry.calories) kCal")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .onDelete(perform: deleteFavorite)
            }
            .navigationTitle("Favoriten")
        }
    }
    
    private func deleteFavorite(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                favorites[index].isFavorite = false
            }
        }
    }
    
}

#Preview {
    FavoritesListView()
}
