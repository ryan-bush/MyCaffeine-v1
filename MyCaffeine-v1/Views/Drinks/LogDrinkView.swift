//
//  LogDrinkView.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 01/12/2023.
//

import SwiftUI
import SwiftData
import HalfASheet

struct LogDrinkView: View {
    @Environment(\.modelContext) var modelContext
    @Query var drinks: [Drink]
    
    @State private var sheetDrinkName = ""
    @State private var sheetDrinkImage = ""
    @State private var sheetDrinkCaffeineType = 0
    @State private var sheetDrinkCaffeineContent = 0.0
    @State private var sheetDrinkSizes = []
    
    @State private var isSheetPresented = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(drinks) { drink in
                        Button {
                            sheetDrinkName = drink.name
                            sheetDrinkImage = drink.image
                            sheetDrinkCaffeineType = drink.caffeineType
                            if(drink.caffeineType == 0) {
                                sheetDrinkCaffeineContent = drink.caffeineContent
                            } else if(drink.caffeineType == 1) {
                                sheetDrinkSizes = drink.drinkSizes
                            }
                            
                            isSheetPresented.toggle()
                        } label: {
                            VStack {
                                Text(drink.name)
                                    .font(.headline)
                                Text("\(drink.caffeineContent)")
                            }
                        }
                    }
                }
                HalfASheet(isPresented: $isSheetPresented, title: "Log Drink") {
                    VStack {
                        Text(sheetDrinkName)
                    }
                }
                .closeButtonColor(.blue)
                .height(.proportional(0.5))
            }
        }
        .navigationTitle("Log Drink")
    }
}

#Preview {
    LogDrinkView()
}
