//
//  MyCaffeine_v1App.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 30/11/2023.
//

import SwiftUI
import SwiftData
import RevenueCat

@main
struct MyCaffeine_v1App: App {
    
    @StateObject var userViewModel = UserViewModel()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Drink.self,
            Log.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: "appl_TdwNUpASqhsTNEnGlgWPzfkLzjL")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userViewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}
