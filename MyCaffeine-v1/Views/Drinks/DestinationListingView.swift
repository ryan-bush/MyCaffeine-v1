//
//  DestinationListingView.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 30/11/2023.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext

    @Query var drinks: [Drink]
    
    init(sort: SortDescriptor<Drink>, searchString: String) {
        _drinks = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    var body: some View {
        List {
            
            ForEach(drinks) { drink in
                NavigationLink(value: drink) {
                    VStack(alignment: .leading) {
                        Text(drink.name)
                            .font(.headline)
                        
                        Text("\(drink.caffeineContent)")
                    }
                }
            }
            .onDelete(perform: deleteDrinks)
        }
    }
    
    func deleteDrinks(_ indexSet: IndexSet) {
        for index in indexSet {
            let drink = drinks[index]
            modelContext.delete(drink)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Drink.name), searchString: "")

}
