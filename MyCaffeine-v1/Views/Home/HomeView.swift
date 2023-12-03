//
//  HomeView.swift
//  MyCaffeine-v1
//
//  Created by Ryan Bush on 30/11/2023.
//

import SwiftUI

struct HomeView: View {
        
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ZStack {
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
        }
    }
}

#Preview {
    HomeView()
}
