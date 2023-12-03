//
//  ContentView.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 30/11/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Label("Home", systemImage: "person.fill")
                }
            MyDrinksView()
                .tabItem{
                    Label("My Drinks", systemImage: "cup.and.saucer.fill")
                }
            SettingsView()
                .tabItem{
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        
    }
}

#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}
