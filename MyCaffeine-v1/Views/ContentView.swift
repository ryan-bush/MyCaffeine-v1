//
//  ContentView.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 30/11/2023.
//

import SwiftUI
import SwiftData
import RevenueCatUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Label("Home", systemImage: "person.fill")
                }
                .environmentObject(userViewModel)
            MyDrinksView()
                .tabItem{
                    Label("My Drinks", systemImage: "cup.and.saucer.fill")
                }
            SettingsView()
                .tabItem{
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .presentPaywallIfNeeded(
            requiredEntitlementIdentifier: "premium",
            purchaseCompleted: { customerInfo in
                print("Purchase completed: \(customerInfo.entitlements)")
            },
            restoreCompleted: { customerInfo in
                // Paywall will be dismissed automatically if "pro" is now active.
                print("Purchases restored: \(customerInfo.entitlements)")
            }
        )
        
    }
}

#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}
