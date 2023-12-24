//
//  HomeView.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 30/11/2023.
//

import SwiftUI
import RevenueCatUI

struct HomeView: View {
    
    @State var isPaywallPresented = false
    @State var displayPaywall = false
    @EnvironmentObject var userViewModel: UserViewModel
        
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ZStack {
                    if !userViewModel.isSubscriptionActive {
                        VStack (alignment: .leading){
                            Text("Sign up for our premium")
                            
                            Button {
                                // TODO
//                                isPaywallPresented = true
                                displayPaywall = true
                            } label: {
                                Text("Let's do it")
                            }
                            .padding(10)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .foregroundColor(Color.white)
                        }
                        .padding(20)
                    }
                    VStack {
                        VStack(alignment: .leading) {
                            Text("Today's Drinks")
                                .font(.headline)
                            
                        }
                    }
                    ZStack {
                        HStack {
                            NavigationLink(destination: LogDrinkView()) {
                                Text("Log Drink")
                                    .foregroundStyle(.white)
                                    .frame(width: geo.size.width / 2.5, height: 20)
                                    .padding()
                                    .background(Color("AccentColor"))
                                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                            }
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .padding()

                        }
                    }
                }
            }
            .sheet(isPresented: $isPaywallPresented, onDismiss: nil) {
                Paywall(isPaywallPresented: $isPaywallPresented)
            }
            .sheet(isPresented: self.$displayPaywall) {
                PaywallView(displayCloseButton: true)
            }
        }
    }
}

#Preview {
    HomeView()
}
