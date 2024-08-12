//
//  ScannerView.swift
//  Calorimeter
//
//  Created by Karsten Kroesch on 12.08.2024.
//

import SwiftUI
import VisionKit

struct ScannerView: View {
    @State var isShowingScanner = true
    @State private var scannedText = "5-901234-123457"
    @State private var productName = "Suchen"
    @State private var selectedPortion: Double = 100
    @State private var productEnergy: Double = 1074
    
    
    var body: some View {
        
        VStack {
            if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                ZStack(alignment: .bottom) {
                    DataScannerRepresentable(
                        shouldStartScanning: $isShowingScanner,
                        scannedText: $scannedText,
                        dataToScanFor: [.barcode(symbologies: [.qr, .ean13])]
                    )
                }
            } else if !DataScannerViewController.isSupported {
                Text("It looks like this device doesn't support the DataScannerViewController")
                    .foregroundStyle(Color.red)
            } else {
                Text("It appears your camera may not be available")
                    .foregroundStyle(Color.red)

            }
            Spacer()
            HStack {
                CustomLabel(label: "EAN-Code")
                Spacer()
                Text("\(scannedText)")
                
            }.padding()
            HStack {
                CustomLabel(label: "Produkt")
                Spacer()
                Button(
                    action: {
                        productName = lookupProduct()
                    }) {
                        Text("\(productName)")
                    }
            }.padding()
            HStack {
                CustomLabel(label: "Brennwert")
                Spacer()
                Text("\(Int(calculateEnergy()))")
                Text("kCal / \(Int(selectedPortion))g")
                    .foregroundStyle(Color.blue)
            }.padding()
            
            // Adjust the size of the portion
            Slider(value: $selectedPortion, in: 50...500, step: 50)
            
            
            // Add the calculated values to log
            Button(
                action: {
                    print(calculateEnergy())
                }) {
                    CustomButtonView(label: "Loggen")
                }
            
            Spacer()
            Button(
                action: {
                    
                }) {
                    Text("Favorit hinzufügen")
                }
        }
        .padding()
    }
    func calculateEnergy() -> Double {
        return Double(selectedPortion / 100) * productEnergy
    }
    func lookupProduct() -> String {
        return "Leckere Rumkugeln"
    }
}
#Preview {
    ScannerView()
}
