//
//  CustomViewComponents.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 12.08.2024.
//

import SwiftUI

struct CustomButtonView: View {
    
    var label: String = "OK"
    
    var body: some View {
        Text(label)
            .font(.body)
            .bold()
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding()
    }
}

struct CustomLabel: View {
    var label: String = "Label"
    
    var body: some View {
        Text(label)
            .font(.body)
            .bold()
            .foregroundStyle(.secondary)
    }
}

struct MenuEntry: View {
    var name: String = "Menu Entry"
    var description: String = "This is an example menu entry."
    var icon: String = "pencil"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                Text(name)
            }
            Text(description)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.bottom)
    }
    
}

#Preview {
    VStack {
        CustomButtonView()
        CustomLabel()
        MenuEntry()
    }
}
