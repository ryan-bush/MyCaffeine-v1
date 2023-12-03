//
//  MyDrinksView.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 30/11/2023.
//

import SwiftUI
import SwiftData

struct MyDrinksView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Drink]()

    @State private var sortOrder = SortDescriptor(\Drink.name)
    @State private var searchText = ""

    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, searchString: searchText)
            .navigationTitle("My Drinks")
            .navigationDestination(for: Drink.self, destination: EditDrinkView.init)
            .searchable(text: $searchText)
            .toolbar {
                Button("Add Destination", systemImage: "plus", action: addDrink)

                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name")
                            .tag(SortDescriptor(\Drink.name))

                        Text("Caffeine Content")
                            .tag(SortDescriptor(\Drink.caffeineContent, order: .reverse))

                        Text("Date Created")
                            .tag(SortDescriptor(\Drink.timestamp, order: .reverse))
                    }
                    .pickerStyle(.inline)
                }
            }

        }
    }
    
    func addDrink() {
        let drink = Drink()
        modelContext.insert(drink)
        path = [drink]
    }

}

#Preview {
    MyDrinksView()
}
