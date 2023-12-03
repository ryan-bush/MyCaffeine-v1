//
//  EditDrinkView.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 30/11/2023.
//

import SwiftUI
import SwiftData

struct EditDrinkView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Bindable var drink: Drink
    
    @State private var newSize = 0.0
    @State private var newCaffeineContent = 0.0
    @State private var newWaterContent = 0.0
    @State private var selectedImage = "coffeeBean1"
    
    let drinkImages = Helpers.populateImageArray()
    
    var body: some View {
        Form {
            TextField("Name", text: $drink.name)
//            TextField("Details", text: $drink.image)
            
            Section("Image") {
                Picker("Image", selection: $drink.image) {
                    ForEach(drinkImages, id: \.self) {
                        Image($0)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .tag($0)
                    }
                }
                .pickerStyle(.navigationLink)
            }

            Section("Caffeine Type") {
                Picker("Caffeine Type", selection: $drink.caffeineType) {
                    Text("mg/100ml").tag(0)
                    Text("Fixed").tag(1)
                }
                .pickerStyle(.segmented)
            }
            if(drink.caffeineType == 0) {
                TextField("Caffeine Content", value: $drink.caffeineContent, format: .number)
            } else if(drink.caffeineType == 1) {
                Section("Sizes") {
                    ForEach(drink.drinkSizes) { size in
                        Text("\(size.size)")
                    }
                    HStack {
                        TextField("Drink Size", value: $newSize, format: .number)
                        TextField("Caffeine Content", value: $newCaffeineContent, format: .number)
                        TextField("Caffeine Content", value: $newWaterContent, format: .number)

                        Button("Add", action: addSize)
                            .disabled(newSize == 0.0 || newCaffeineContent == 0.0 || newWaterContent == 0.0)
                    }
                }
                
            }
            
        }
        .navigationTitle("Edit Drink")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addSize() {
//        guard newSize.isEmpty == false else { return }

        withAnimation {
            let size = DrinkSize(timestamp: Date.now, size: newSize, caffeineContent: newCaffeineContent, waterContent: newWaterContent)
            drink.drinkSizes.append(size)
            newSize = 0.0
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Drink.self, configurations: config)

        let example = Drink(timestamp: Date.now, uuid: UUID(), name: "Coca Cola", image: "img01", caffeineType: 0, caffeineContent: 10.5)
        return EditDrinkView(drink: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
