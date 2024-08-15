//
//  DashboardView.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 10.08.2024.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            VStack {
                WeightChartView()
                MealChartView()
            }
        }
    }
}

#Preview {
    DashboardView()
}
